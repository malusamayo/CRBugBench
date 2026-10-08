#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `fastapi/utils.py`:

This pull request introduces the defect later reported as "JSON output reordered by pydantic @validator". The
problem a user observed, and its root cause:

This isn't a big problem, but I'm wondering if it's possible to keep the JSON output key ordering unaffected by the presence of a Pydantic `@validator(...)`? I like consistency. 🤷‍♂️

I have this pydantic model structure:
```
class IngredientBase(BaseIngredientMixin):
    name: str = None
    unit: str = None
    unit_price: decimal.Decimal = None
    flavour_warning: bool = None

    @validator('unit')
    def valid_units_only(cls, v):
        choices = set(SingleIngredientTable.unit_choices.keys())
        if v and v not in choices:
            raise ValueError(f'must be one of {choices}')
        return v


class IngredientIn(IngredientBase):
    pass


class IngredientNew(IngredientIn):
    name: str = ...
    unit: str = ...
    unit_price: decimal.Decimal = ...


class IngredientOut(IngredientBase, TestModelMixin, TimestampModelMixin, IDModelMixin):
    pass
```

This will produce:
```
{
  "unit": "IU",
  "id": "sing_qOYSyqZhfOcJKHsfVz7tnfP6M",
  "created": 1571357369,
  "updated": 1571418480,
  "is_test": false,
  "name": "Vitamin C",
  "unit_price": 10.568536363534536,
  "flavour_warning": false
}
```
Without the validator, it produces what I would expect:
```
{
  "id": "sing_qOYSyqZhfOcJKHsfVz7tnfP6M",
  "created": 1571357369,
  "updated": 1571418480,
  "is_test": false,
  "name": "Vitamin C",
  "unit": "IU",
  "unit_price": 10.568536363534536,
  "flavour_warning": false
}
```

How can I continue to use `@validator`s and maintain the expected JSON key ordering?

**Edit**: I can pull out the validator into a 'mixin' class that I apply ONLY to the `IngredientIn` and `IngredientNew` models (leaving `IngredientOut` untouched). But is that my only path here?

This same root cause must be fixed before merging.
REVIEW_EOF
