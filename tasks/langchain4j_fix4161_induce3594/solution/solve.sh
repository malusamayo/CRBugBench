#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `langchain4j-agentic/src/main/java/dev/langchain4j/agentic/supervisor/SupervisorAgentServiceImpl.java`:

This pull request introduces the defect later reported as "[BUG] Cannot invoke SupervisorAgent in a sequenceBuilder". The
problem a user observed, and its root cause:

**Describe the bug**
Hi team, when I try to use a SupervisorAgent in sequenceBuilder, the error occurs.

**Log and Stack trace**
```
Failed to invoke agent method: public abstract java.lang.String dev.langchain4j.agentic.supervisor.SupervisorAgent.invoke(java.lang.String)] with root cause

java.lang.IllegalArgumentException: wrong number of arguments: 0 expected: 1
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.checkArgumentCount(DirectMethodHandleAccessor.java:329) ~[na:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:101) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at dev.langchain4j.agentic.internal.AgentInvoker.internalInvoke(AgentInvoker.java:52) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.AgentInvoker.invoke(AgentInvoker.java:40) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.AgentExecutor.internalExecute(AgentExecutor.java:56) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.AgentExecutor.execute(AgentExecutor.java:32) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.AgentExecutor.execute(AgentExecutor.java:20) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.PlannerBasedInvocationHandler$PlannerLoop.loop(PlannerBasedInvocationHandler.java:221) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.PlannerBasedInvocationHandler.executeAgentMethod(PlannerBasedInvocationHandler.java:187) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at dev.langchain4j.agentic.internal.PlannerBasedInvocationHandler.invoke(PlannerBasedInvocationHandler.java:166) ~[langchain4j-agentic-1.9.0-beta16.jar:na]
	at jdk.proxy2/jdk.proxy2.$Proxy129.chatStream(Unknown Source) ~[na:na]
```

**To Reproduce**
```
        SupervisorAgent mockAgent = AgenticServices.supervisorBuilder()
                .chatModel(chatModel)
                .subAgents(
                        AgenticServices.agentAction(agenticScope -> agenticScope.writeState("response", agenticScope.readState("request", "user input")))
                )
                .outputKey("response")
                .build();
        return AgenticServices
                .sequenceBuilder(ChatboxAgent.class)
                .subAgents(mockAgent)
                .outputKey("response")
                .build();
```

**Expected behavior**
<!-- A clear and concise description of what you expected to happen. -->

**Please complete the following information:**
- LangChain4j version: 1.9.0
- LLM(s) used: gpt-4.1
- Java version: 21
- Spring Boot version (if applicable): 3.5.0

**Additional context**
I found that when a SupervisorAgent is invoked in a sequenceBuilder, its argument is empty. (which means `AgentUtil.agentInvocationArguments(agenticScope, arguments());` is None)

This same root cause must be fixed before merging.
REVIEW_EOF
