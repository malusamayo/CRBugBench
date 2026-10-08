#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `fastapi/routing.py` (around line 364): ```suggestion
            root_path = cast(str, request.scope.get("root_path", "")).rstrip("/")
            endpoint_ctx["path"] = (
                f"{request.method} {root_path}/{dependant.path.lstrip('/')}"
            )
```
Should we handle `root_path` here?

It would be helpful for mounted sub-apps.
In current implementation `path` will not contain mounting point for sub-apps and that might be confusing.

<details>

```py
from fastapi import FastAPI, Request, WebSocket
from fastapi.exceptions import (
    RequestValidationError,
    WebSocketRequestValidationError,
)
from fastapi.testclient import TestClient
from pydantic import BaseModel


class Item(BaseModel):
    id: int
    name: str


class ExceptionCapture:
    def __init__(self):
        self.exception = None

    def capture(self, exc):
        self.exception = exc
        return exc


app = FastAPI()

sub_app = FastAPI()


captured_exception = ExceptionCapture()


@app.exception_handler(RequestValidationError)
@sub_app.exception_handler(RequestValidationError)
async def request_validation_handler(request: Request, exc: RequestValidationError):
    captured_exception.capture(exc)
    raise exc


@app.exception_handler(WebSocketRequestValidationError)
@sub_app.exception_handler(WebSocketRequestValidationError)
async def websocket_validation_handler(
    websocket: WebSocket, exc: WebSocketRequestValidationError
):
    captured_exception.capture(exc)
    raise exc


@sub_app.get("/users/{user_id}")
def get_user_router(user_id: int):
    return {"user_id": user_id}  # pragma: no cover


app.mount(path="/sub", app=sub_app)


client = TestClient(app, raise_server_exceptions=False)


def test_subapp_request_validation_error_includes_endpoint_context():
    captured_exception.exception = None
    try:
        client.get("/sub/users/invalid")
    except Exception:
        pass

    assert captured_exception.exception is not None
    error_str = str(captured_exception.exception)
    assert "get_user" in error_str
    assert "/sub/users/" in error_str  # <= Currently fails
```

</details>
REVIEW_EOF
