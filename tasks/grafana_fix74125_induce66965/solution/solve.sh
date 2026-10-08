#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `.betterer.results`:

This pull request introduces the defect later reported as "Dashboards: Possible regression detected in time range variables under the `refactorVariablesTimeRange` feature flag.". The
problem a user observed, and its root cause:

After trying out the new algorithm for resolving time range variables behind the `refactorVariablesTimeRange` feature flag, we've received feedback indicating a potential regression: 

When template variable is configured to be reloaded on time range change, and QueryType is Labelvalues with metrics is used, the time range change does not trigger template variable reload.
> 
> This result that on every time range change outdated template variable are used. This does not happen with old template variable loading as all one or more times.
> 
> How to repro:
> I created simple dashboards with some dependencies on template variables like below, and using promsource, label x!=”value” is just for debugging to see which query is which.
> 
> Template variable using Query Type label values with metrics, and all configured to be reloaded on time range change
> ```
> job                                                   label_values(http_server_requests_seconds_count{x!="job"},job)
> teamname                                    label_values(http_server_requests_seconds_count{x!="teamname", job=~"$job"},teamname)
> country                                          label_values(http_server_requests_seconds_count{x!="country", job=~"$job"},country)
> severity                                          label_values(http_server_requests_seconds_count{x!="severity", job=~"$job"},severity)
> dnsname                                       label_values(http_server_requests_seconds_count{x!="dnsname", job=~"$job", teamname=~"$teamname", country=~"$country", severity=~"$severity"},dnsname)
> dnsname_single                         http_server_requests_seconds_count{x!="dnsname_single", job=~"$job", teamname=~"$teamname", country=~"$country", severity=~"$severity", dnsname=~"$dnsname"}
> ```
> 
> Template variables using query Type Query Results with regexp /.*dnsname="(.*?)".*/ works
> ```
> 5xx:                                                  query_result( increase(http_server_requests_seconds_count{job=~"$job", dnsname=~"$appall", status=~"5..|None"}[$__range]  ) > 0)
> alerts                                               query_result (max_over_time(ALERTS{x!="alerts", job=~"$job", dnsname=~"$dnsname", alertstate="active"}[$__range:$range]  ) > 0)
> ```
> 
> Then just change time range and you notice that only template variables using Query results are reloaded, most template variables are not reloaded and contains wrong data.
> 
> What works as expected:
> Changing data source (no time range change) result reload of all template variables.
> Changing template variable like country value (no time range change) values result correctly reload of dependent variable only. All were not reloaded.
> 
> I also notice that reloading panels is not optimal, but this happen also with legacy templating.
> - Normal panels are refreshed correctly after timerange change when all template queries competed after “annotation query”.
> - If panel use “repeat by variables”, then visible repeated panels are refreshed when template variable are loaded, and again after “annotation query” al are reloaded. Cannot repro on small test dashboards. The parent panel which is repeated by variable is correctly loaded after “annotation”, but all repeated one are loaded twice.

This same root cause must be fixed before merging.
REVIEW_EOF
