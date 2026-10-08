#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `langchain4j-ollama/src/main/java/dev/langchain4j/model/ollama/OllamaMessagesUtils.java`:

This pull request introduces the defect later reported as "[BUG] When tool is a method without parameters, the handling of parameters in ToolSpecification will result in an error.". The
problem a user observed, and its root cause:

<!-- Please provide as many details as possible, this will help us to deliver a fix as soon as possible. Thank you! -->

**Describe the bug**
<!-- A clear and concise description of what the bug is. -->
When tool is a method without parameters, the handling of parameters in ToolSpecification will result in an error.


**Log and Stack trace**
<!-- Please provide a log and a stack trace (with exception), if applicable. -->
```
java.lang.NullPointerException: Cannot invoke "dev.langchain4j.agent.tool.ToolParameters.properties()" because the return value of "dev.langchain4j.agent.tool.ToolSpecification.parameters()" is null

	at dev.langchain4j.model.ollama.OllamaMessagesUtils.lambda$toOllamaTools$3(OllamaMessagesUtils.java:41)
	at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:197)
	at java.base/java.util.ArrayList$ArrayListSpliterator.forEachRemaining(ArrayList.java:1708)
	at java.base/java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:509)
	at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:499)
	at java.base/java.util.stream.ReduceOps$ReduceOp.evaluateSequential(ReduceOps.java:921)
	at java.base/java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:234)
	at java.base/java.util.stream.ReferencePipeline.collect(ReferencePipeline.java:682)
	at dev.langchain4j.model.ollama.OllamaMessagesUtils.toOllamaTools(OllamaMessagesUtils.java:46)
	at dev.langchain4j.model.ollama.OllamaChatModel.generate(OllamaChatModel.java:106)
	at dev.langchain4j.service.DefaultAiServices$1.invoke(DefaultAiServices.java:218)
	at com.ai.test.$Proxy10.chat(Unknown Source)
	at com.ai.test.ToolBug2.test1(ToolBug2.java:54)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at java.base/java.util.ArrayList.forEach(ArrayList.java:1596)
	at java.base/java.util.ArrayList.forEach(ArrayList.java:1596)
```

**To Reproduce**
<!-- Please provide a relevant code snippets to reproduce this bug. -->

```
 ChatLanguageModel model = OllamaChatModel.builder()
            .baseUrl("http://localhost:11434")
            .modelName("qwen2:7b")
            .maxRetries(1)
            .build();
    static class Tools {
        @Tool
        String currentTime() {
            String now= DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(LocalDateTime.now());
            log.info("currentTime: "+now);
            return now;
        }

    }
    @SneakyThrows
    @Test
    public void test1(){
        ToolTest.Assistant assistant = AiServices.builder(ToolTest.Assistant.class)
                .chatLanguageModel(model)
                .tools(new Tools())
                .build();
        System.out.println(assistant.chat("What is the time?"));
    }
```

**Expected behavior**
<!-- A clear and concise description of what you expected to happen. -->

**Please complete the following information:**
- LangChain4j version:  0.34
- LLM(s) used:   OLLAMA
- Java version:   21
- Spring Boot version (if applicable): 

**Additional context**
<!-- Add any other context about the problem here. -->
modify OllamaMessagesUtils.toOllamaTools as bellow:

```
   static List<Tool> toOllamaTools(List<ToolSpecification> toolSpecifications) {
        return toolSpecifications.stream().map(toolSpecification ->{

                    Parameters parameters=null;
                    if(toolSpecification.parameters()!=null){
                        parameters=Parameters.builder()
                                .properties(toolSpecification.parameters().properties())
                                .required(toolSpecification.parameters().required())
                                .build();
                    }else{
                        parameters=Parameters.builder().build();
                    }
                    return Tool.builder()
                            .function(Function.builder()
                                    .name(toolSpecification.name())
                                    .description(toolSpecification.description())
                                    .parameters(parameters)
                                    .build())
                            .build();

                })
                .collect(Collectors.toList());
    }
```

This same root cause must be fixed before merging.
REVIEW_EOF
