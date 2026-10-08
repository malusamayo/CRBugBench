#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `fastapi/openapi/docs.py`:

This pull request introduces the defect later reported as "DeepLinking in swagger-ui is broken". The
problem a user observed, and its root cause:

i'm not a native speaker of English. Sorry for my poor English.

**Describe the bug**
`deepLinking` is not working in docs

**To Reproduce**

Steps to reproduce the behavior:
```python
from fastapi import FastAPI
from pydantic import BaseModel
from starlette.responses import Response
from starlette.responses import HTMLResponse

app = FastAPI(
    docs_url='/',
    redoc_url=None,
    swagger_ui_oauth2_redirect_url=None,
    openapi_url='/openapi.json',
)


class M(BaseModel):
    h1: str
    h2: str
    h3: str
    h4: str
    h5: str
    h6: str
    h7: str
    h8: str


@app.get('/1', response_model=M)
async def i1():
    return Response()


@app.get('/2', response_model=M)
async def i2():
    return Response()


@app.get('/3', response_model=M)
async def i3():
    return Response()


@app.get('/4', response_model=M)
async def i4():
    return Response()
```

**Expected behavior**
`deepLinking` feature of swagger ui not working, some api should expand and browser should scoll to that section automaticly

**Environment:**
 - OS: Windows,
 - FastAPI Version 0.38.1
- Python 3.7.4

**Additional context**
It can be fixed by 
```python
@app.get('/')
async def index():
    return HTMLResponse(
        '''
<!DOCTYPE html>
<html lang="zh-Hans">
<head>
  <meta charset="utf-8">
  <title>Pol server - Swagger UI</title>
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui.css" >
  <link rel="shortcut icon" href="https://bgm.tv/img/favicon.ico" type="image/x-icon" />
</head>
<body>

<div id="swagger-ui"></div>

<script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui-bundle.js"> </script>
<script>
window.onload = function() {
  window.ui = SwaggerUIBundle({
    url: '/openapi.json',
    dom_id: '#swagger-ui',
    layout: 'BaseLayout',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIBundle.SwaggerUIStandalonePreset
    ]
  });
};
</script>
</body>
</html>
'''
    )
```

I'm not familiar with swagger ui so I copy this from another example page, and I can't figure it out what fastapi's configuration not working

```html
    <! doctype html>
    <html>
    <head>
    <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui.css">
    <link rel="shortcut icon" href="https://fastapi.tiangolo.com/img/favicon.png">
    <title>Pol server - Swagger UI</title>
    </head>
    <body>
    <div id="swagger-ui">
    </div>
    <script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui-bundle.js"></script>
    <!-- `SwaggerUIBundle` is now available on the page -->
    <script>
    const ui = SwaggerUIBundle({
        url: '/openapi.json',
    
        dom_id: '#swagger-ui',
        presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIBundle.SwaggerUIStandalonePreset
        ],
        layout: "BaseLayout",
        deepLinking: true
    })
    </script>
    </body>
    </html>
```

This same root cause must be fixed before merging.
REVIEW_EOF
