#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/core/mergeConfig.js`:

This pull request introduces the defect later reported as "Form-data resubmitting is broken". The
problem a user observed, and its root cause:

### Describe the bug

Hello everyone. I've faced an issue. I hope someone could help me.

Here is a simple dummy code example:
```
const axiosInstance = axios.create({
  headers: {
    "Content-Type": "application/json;charset=utf-8",
  },
});

let retry = false;

axiosInstance.interceptors.response.use(undefined, (error) => {
  if (retry) return Promise.reject(error);
  retry = true;

  return axiosInstance.request(error.config);
});

axiosInstance.post("example.com/form", new FormData(), {
  headers: {
    "Content-Type": "multipart/form-data",
  },
});
```
[`xhrAdapder`](https://github.com/axios/axios/blob/d844227411263fab39d447442879112f8b0c8de5/lib/adapters/xhr.js#L68) sets Content-Type to false, so that the browser can set it itself.

The first request gets a merged config:
```
{
  headers: {
    "Content-Type": false,
  },
  data: FormData {}
}
```

 Inside the response interceptor `error.config` has the headers as an AxiosHeaders instance and looks like 
```
{
  headers: AxiosHeaders {
    "Content-Type": false,
  },
  data: FormData {}
}
```

So when axios submits the request again:
[`headersToObject`](https://github.com/axios/axios/blob/d844227411263fab39d447442879112f8b0c8de5/lib/core/mergeConfig.js#L6) uses [`AxiosHeaders.prototype.toJSON`](https://github.com/axios/axios/blob/d844227411263fab39d447442879112f8b0c8de5/lib/core/AxiosHeaders.js#L226), which removes all `false` values. Therefore [`mergeConfig`](https://github.com/axios/axios/blob/d844227411263fab39d447442879112f8b0c8de5/lib/core/mergeConfig.js#L17) returns a merged config which looks like
```
{
  headers: AxiosHeaders {
    "Content-Type": "application/json;charset=utf-8",
  },
  data: FormData {}
}
```
So [`dispatchRequest `](https://github.com/axios/axios/blob/d844227411263fab39d447442879112f8b0c8de5/lib/core/dispatchRequest.js#L40) transforms the data to JSON string. And the request ends up with a config:
```
{
  headers: AxiosHeaders {
    "Content-Type": "application/json;charset=utf-8",
  },
  data: "{}"
}
```

But if the response interceptor looks like
```
axiosInstance.interceptors.response.use(undefined, (error) => {
  if (retry) return Promise.reject(error);
  retry = true;

  return axiosInstance.request({
    ...error.config,
    headers: { ...error.config.headers },
  });
});
```
everything works great.

Is it necessary that `headersToObject` uses `AxiosHeaders.prototype.toJSON`? Could it be switched to `{ ...thing }`?

### To Reproduce

[sandbox](https://codesandbox.io/p/sandbox/musing-dubinsky-rywnkh?layout=%257B%2522sidebarPanel%2522%253A%2522EXPLORER%2522%252C%2522rootPanelGroup%2522%253A%257B%2522direction%2522%253A%2522horizontal%2522%252C%2522contentType%2522%253A%2522UNKNOWN%2522%252C%2522type%2522%253A%2522PANEL_GROUP%2522%252C%2522id%2522%253A%2522ROOT_LAYOUT%2522%252C%2522panels%2522%253A%255B%257B%2522type%2522%253A%2522PANEL_GROUP%2522%252C%2522contentType%2522%253A%2522UNKNOWN%2522%252C%2522direction%2522%253A%2522vertical%2522%252C%2522id%2522%253A%2522clsrnzcx800063b5vcorpgeuc%2522%252C%2522sizes%2522%253A%255B70%252C30%255D%252C%2522panels%2522%253A%255B%257B%2522type%2522%253A%2522PANEL_GROUP%2522%252C%2522contentType%2522%253A%2522EDITOR%2522%252C%2522direction%2522%253A%2522horizontal%2522%252C%2522id%2522%253A%2522EDITOR%2522%252C%2522panels%2522%253A%255B%257B%2522type%2522%253A%2522PANEL%2522%252C%2522contentType%2522%253A%2522EDITOR%2522%252C%2522id%2522%253A%2522clsrnzcx800023b5v9m71md87%2522%257D%255D%257D%252C%257B%2522type%2522%253A%2522PANEL_GROUP%2522%252C%2522contentType%2522%253A%2522SHELLS%2522%252C%2522direction%2522%253A%2522horizontal%2522%252C%2522id%2522%253A%2522SHELLS%2522%252C%2522panels%2522%253A%255B%257B%2522type%2522%253A%2522PANEL%2522%252C%2522contentType%2522%253A%2522SHELLS%2522%252C%2522id%2522%253A%2522clsrnzcx800033b5vm9pddvx2%2522%257D%255D%252C%2522sizes%2522%253A%255B100%255D%257D%255D%257D%252C%257B%2522type%2522%253A%2522PANEL_GROUP%2522%252C%2522contentType%2522%253A%2522DEVTOOLS%2522%252C%2522direction%2522%253A%2522vertical%2522%252C%2522id%2522%253A%2522DEVTOOLS%2522%252C%2522panels%2522%253A%255B%257B%2522type%2522%253A%2522PANEL%2522%252C%2522contentType%2522%253A%2522DEVTOOLS%2522%252C%2522id%2522%253A%2522clsrnzcx800053b5v2v1qknfe%2522%257D%255D%252C%2522sizes%2522%253A%255B100%255D%257D%255D%252C%2522sizes%2522%253A%255B50%252C50%255D%257D%252C%2522tabbedPanels%2522%253A%257B%2522clsrnzcx800023b5v9m71md87%2522%253A%257B%2522tabs%2522%253A%255B%257B%2522id%2522%253A%2522clsrnzcx700013b5vov4s3nzy%2522%252C%2522mode%2522%253A%2522permanent%2522%252C%2522type%2522%253A%2522FILE%2522%252C%2522filepath%2522%253A%2522%252Fsrc%252Findex.js%2522%252C%2522state%2522%253A%2522IDLE%2522%257D%255D%252C%2522id%2522%253A%2522clsrnzcx800023b5v9m71md87%2522%252C%2522activeTabId%2522%253A%2522clsrnzcx700013b5vov4s3nzy%2522%257D%252C%2522clsrnzcx800053b5v2v1qknfe%2522%253A%257B%2522id%2522%253A%2522clsrnzcx800053b5v2v1qknfe%2522%252C%2522activeTabId%2522%253A%2522clsro3dgk00893b5vybn1w0nx%2522%252C%2522tabs%2522%253A%255B%257B%2522id%2522%253A%2522clsrnzcx800043b5v2kbliqz5%2522%252C%2522mode%2522%253A%2522permanent%2522%252C%2522type%2522%253A%2522UNASSIGNED_PORT%2522%252C%2522port%2522%253A0%252C%2522path%2522%253A%2522%252F%2522%257D%252C%257B%2522type%2522%253A%2522SANDBOX_INFO%2522%252C%2522id%2522%253A%2522clsro3dgk00893b5vybn1w0nx%2522%252C%2522mode%2522%253A%2522permanent%2522%257D%255D%257D%252C%2522clsrnzcx800033b5vm9pddvx2%2522%253A%257B%2522tabs%2522%253A%255B%255D%252C%2522id%2522%253A%2522clsrnzcx800033b5vm9pddvx2%2522%257D%257D%252C%2522showDevtools%2522%253Atrue%252C%2522showShells%2522%253Atrue%252C%2522showSidebar%2522%253Atrue%252C%2522sidebarPanelSize%2522%253A15%257D)

### Code snippet

_No response_

### Expected behavior

The "Content-Type" header shouldn't change and the data shouldn't be converted to string.

### Axios Version

1.6.7

### Adapter Version

_No response_

### Browser

Chrome

### Browser Version

119.0.6045.159

### Node.js Version

_No response_

### OS

OSX 14.2

### Additional Library Versions

_No response_

### Additional context/Screenshots

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
