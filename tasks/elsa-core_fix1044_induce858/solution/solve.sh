#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/samples/dashboard/aspnetcore/ElsaDashboard.Samples.AspNetCore.Monolith/Startup.cs`:

This pull request introduces the defect later reported as "CORS Issue". The
problem a user observed, and its root cause:

I'm running the AspnetCore Monolith Dashboard sample.

Workflow:,

![image](https://user-images.githubusercontent.com/19210281/119568535-25eb5300-bd73-11eb-9df6-533fffd11d05.png)

This problem happens in the HttpReponse Activity, the HttpEndpoint works fine

I'm getting an error on the client which I can't catch in the server, I think the problem happens in:

``` 
Elsa.Activities.Http -> WriteHttpResponse -> OnExecuteAsync(ActivityExecutionContext context)
```

It seems that `response.WriteAsync` fires some background thread that fails at some point but the exception is not caught:

```csharp
        /// <summary>
        /// The headers to send along with the response.
        /// </summary>
        [ActivityProperty(Hint = "Additional headers to write.", UIHint = ActivityPropertyUIHints.Json)]
        public HttpResponseHeaders? ResponseHeaders { get; set; }

        protected override async ValueTask<IActivityExecutionResult> OnExecuteAsync(ActivityExecutionContext context)
        {
    
            var httpContext = _httpContextAccessor.HttpContext ?? new DefaultHttpContext();
            var response = httpContext.Response;

          ...

            var bodyText = Content;

            if (!string.IsNullOrWhiteSpace(bodyText))
            {
                try
                {
                    
                    await response.WriteAsync(bodyText, context.CancellationToken); 
                  
                    await Task.Delay(5000);      <--CLIENT FAILS HERE
                    Console.WriteLine("Delay End");
                  
                   
                }
                catch(Exception ex)
                {
                    var z = ex;
                }
            }
           
            return Done();
        }
```

The API function has not returned when the client already fails:

![image](https://user-images.githubusercontent.com/19210281/119567515-0a337d00-bd72-11eb-8594-8d63e453b212.png)

![image](https://user-images.githubusercontent.com/19210281/119567541-0ef83100-bd72-11eb-9e4b-69d344cc8283.png)

Client only says "Unknown Backend Error, Status = 0"

The workflow instances are created and Finished OK

![image](https://user-images.githubusercontent.com/19210281/119568723-6b0f8500-bd73-11eb-9615-fcc33b69dd99.png)


This doesn't happen if the call is made from the browser, so it has to be CORS related

I'm using Angular 10, tried in a clean empty project, no credentials, no extra headers in the http call




(English is not my primary language, sorry for the errors)

This same root cause must be fixed before merging.
REVIEW_EOF
