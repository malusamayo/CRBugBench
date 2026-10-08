#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openbb_platform/core/openbb_core/provider/standard_models/options_chains.py`:

This pull request introduces the defect later reported as "[Bug] OptionsChainsData schema/serializer mismatch: columnar schema vs record-list wire format". The
problem a user observed, and its root cause:

## Bug                                                                                                                                                                                                                                                  

`OptionsChainsData.model_serializer` returns a list of records, but the Pydantic model is declared as a columnar object (`list[float | None]`, `list[str]`, etc.). This means the OpenAPI / JSON Schema generated from the model declares `OBBject.results` as an **object** with columnar list fields, while the wire format the REST API actually emits is an **array of records**. 
                                                                                                                                                                                                                                                Pydantic's own `model_validate` is happy (input is columnar) and the Python client / REST JSON callers work fine (they iterate `results` as records). 

The mismatch only surfaces in consumers that validate the HTTP response against the declared schema — notably `openbb-mcp-server` via FastMCP — which raises the generic jsonschema error `"not valid under any of the given schemas"` on every single tool call that uses this endpoint.

Affects **all** options-chain providers (`yfinance`, `intrinio`, `cboe`, `tradier`, `tmx`, `deribit`), because they all inherit `OptionsChainsData`.

## Environment

- OpenBB Platform (develop @ 8cc70fa1c8a)
- `openbb-mcp-server==1.4.0`
- Python 3.11

## Minimal repro (no MCP needed)

```python
import httpx, json, subprocess, time

# Start REST API
p = subprocess.Popen(
    ["python", "-m", "uvicorn", "openbb_core.api.rest_api:app",
     "--host", "127.0.0.1", "--port", "8765", "--log-level", "warning"])
time.sleep(5)

# Grab schema and a real response, compare shapes
spec = httpx.get("http://127.0.0.1:8765/openapi.json").json()
results_schema = spec["components"]["schemas"]["OBBject_OptionsChains"]["properties"]["results"]
# → oneOf { DeribitOptionsChainsData | IntrinioOptionsChainsData | ... }, all object-type columnar schemas

resp = httpx.get("http://127.0.0.1:8765/api/v1/derivatives/options/chains",
                 params={"provider": "yfinance", "symbol": "SPY"}).json()
print(type(resp["results"]))   # <class 'list'>
print(resp["results"][0])      # {'underlying_symbol': 'SPY', 'contract_symbol': '...', ...}  ← record, not columnar object
p.terminate()
```

Declared schema: `results: object` (columnar)
Actual response: `results: array<object>` (record list)

## Why this happens
`openbb_core/provider/standard_models/options_chains.py:354-371` defines a custom `@model_serializer` that zips the columnar fields into records:

```python
@model_serializer
def model_serialize(self):
    data: dict = {}
    for field in self.model_fields:
        value = getattr(self, field)
        if isinstance(value, list):
            if value:
                if isinstance(value[0], datetime):
                    data[field] = [str(v) if v else None for v in value]
                else:
                    data[field] = value
        else:
            data[field] = value
    records = [dict(zip(data.keys(), values)) for values in zip(*data.values())]
    return records
```

Changing the serialized shape here does not update the JSON Schema generated for the model — Pydantic / FastAPI still derive the schema from the typed fields.

## Impact

- `openbb-mcp-server` tool calls to `derivatives_options_chains` always return a validation error to the MCP client instead of the data, regardless of provider.
- Anyone else consuming the OpenAPI spec to generate strict clients (TypeScript with `oneOf` strictness, Go with JSON Schema validation, etc.) hits the same mismatch.

## Possible directions

The fix is a design choice; happy to submit a PR once a direction is agreed on.

- **(A)** Drop the record-reshape serializer and return columnar JSON. Matches the declared schema. Breaking change for anyone currently relying on `results[0]`-style record access over HTTP.
- **(B)** Redefine `OptionsChainsData` as a record-list (each field non-list, and `results` typed as `list[OptionsChainRecord]`). Matches the serializer. Biggest refactor — touches `OptionsChainsProperties` helper methods that assume columnar storage.
- **(C)** Keep the Pydantic model as-is but override the generated OpenAPI schema for `OBBject_OptionsChains.results` to `array<OptionsChainRecord>`. Smallest change and non-breaking for runtime consumers, but requires a custom schema hook.

Happy to put together a PR for whichever direction maintainers prefer. My lean is **(C)** — it's the only option that keeps the wire format and the existing Python-side helpers stable.

This same root cause must be fixed before merging.
REVIEW_EOF
