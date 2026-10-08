#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/stirling/software/SPDF/model/User.java`:

This pull request introduces the defect later reported as "[Bug]: When synchronizing the browser settings to the database SQL Error: 22001, SQLState: 22001". The
problem a user observed, and its root cause:

### The Problem

When synchronizing the browser settings with the database, the error `SQL Error: 22001, SQLState: 22001` is triggered.
An attempt is made to write a character string that is too long; the limit is 255

### Version of Stirling-PDF

0.26.1

### Last Working Version of Stirling-PDF

_No response_

### Page Where the Problem Occurred

http://localhost:8080/account

### Docker Configuration

_No response_

### Relevant Log Output

```txt
Received parameter map: {languageCode=[Ljava.lang.String;@7b5c310f, boredWaiting=[Ljava.lang.String;@5a7ec44b, dontShowSurvey=[Ljava.lang.String;@2b00fa8e, cacheInputs=[Ljava.lang.String;@3c9a8dce, dark-mode=[Ljava.lang.String;@26d4071b, surveyVersion=[Ljava.lang.String;@aa4c316, pdfjs.history=[Ljava.lang.String;@26dc9c46}
Processed updates: {pdfjs.history={"files":[{"fingerprint":"289a577a8b729810b85600c76ce988b7","sidebarView":1,"page":1,"zoom":"auto","scrollLeft":-214,"scrollTop":843,"rotation":0,"scrollMode":0},{"fingerprint":"421137babe02df89a3cf528b066cb936","sidebarView":1,"page":1,"zoom":"auto","scrollLeft":-42,"scrollTop":3507,"rotation":270,"scrollMode":2,"spreadMode":2}]}, surveyVersion=1.1, cacheInputs=disabled, languageCode=de_DE, dontShowSurvey=true, dark-mode=on, boredWaiting=enabled}
10:39:34.818 [qtp454636210-44] WARN  o.h.e.jdbc.spi.SqlExceptionHelper - SQL Error: 22001, SQLState: 22001
10:39:34.818 [qtp454636210-44] ERROR o.h.e.jdbc.spi.SqlExceptionHelper - Wert zu gro├ƒ / lang f├╝r Feld "SETTING_VALUE CHARACTER VARYING(255)": "'{""files"":[{""fingerprint"":""289a577a8b729810b85600c76ce988b7"",""sidebarView"":1,""pa... (332)"
Value too long for column "SETTING_VALUE CHARACTER VARYING(255)": "'{""files"":[{""fingerprint"":""289a577a8b729810b85600c76ce988b7"",""sidebarView"":1,""pa... (332)"; SQL statement:
insert into user_settings (user_id,setting_key,setting_value) values (?,?,?) [22001-214]
10:39:34.832 [qtp454636210-44] WARN  o.e.j.ee10.servlet.ServletChannel - /pdf/api/v1/user/updateUserSettings
jakarta.servlet.ServletException: Request processing failed: org.springframework.dao.DataIntegrityViolationException: could not execute statement [Wert zu gro├ƒ / lang f├╝r Feld "SETTING_VALUE CHARACTER VARYING(255)": "'{""files"":[{""fingerprint"":""289a577a8b729810b85600c76ce988b7"",""sidebarView"":1,""pa... (332)"
Value too long for column "SETTING_VALUE CHARACTER VARYING(255)": "'{""files"":[{""fingerprint"":""289a577a8b729810b85600c76ce988b7"",""sidebarView"":1,""pa... (332)"; SQL statement:
insert into user_settings (user_id,setting_key,setting_value) values (?,?,?) [22001-214]] [insert into user_settings (user_id,setting_key,setting_value) values (?,?,?)]; SQL [insert into user_settings (user_id,setting_key,setting_value) values (?,?,?)]
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1022)
        at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:914)
        at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:547)
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885)
        at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:614)
        at org.eclipse.jetty.ee10.servlet.ServletHolder.handle(ServletHolder.java:736)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$ChainEnd.doFilter(ServletHandler.java:1614)
        at org.eclipse.jetty.ee10.websocket.servlet.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:195)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at stirling.software.SPDF.config.security.IPRateLimitingFilter.doFilter(IPRateLimitingFilter.java:62)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at stirling.software.SPDF.config.security.UserBasedRateLimitingFilter.doFilterInternal(UserBasedRateLimitingFilter.java:48)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:110)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:110)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at stirling.software.SPDF.config.MetricsFilter.doFilterInternal(MetricsFilter.java:61)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
        at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
        at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1586)
        at org.springframework.web.filter.CompositeFilter$VirtualFilterChain.doFilter(CompositeFilter.java:108)
        at org.springframework.security.web.FilterChainProxy.lambda$doFilterInternal$3(FilterChainProxy.java:231)
        at org.springframework.security.web.ObservationFilterChainDecorator$FilterObservation$SimpleFilterObservation.lambda$wrap$1(ObservationFilterChainDecorator.java:479)
        at org.springframework.security.web.ObservationFilterChainDecorator$AroundFilterObservation$SimpleAroundFilterObservation.lambda$wrap$1(ObservationFilterChainDecorator.java:340)
        at org.springframework.security.web.ObservationFilterChainDecorator.lambda$wrapSecured$0(ObservationFilterChainDecorator.java:82)
        at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:128)
        at org.springframework.security.web.access.intercept.AuthorizationFilter.doFilter(AuthorizationFilter.java:100)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227)
        at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137)
        at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:126)
        at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:120)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227)
        at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137)
        at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:131)
        at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:85)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240)
        at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFi

This same root cause must be fixed before merging.
REVIEW_EOF
