#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `python/semantic_kernel/agents/agent.py`:

This pull request introduces the defect later reported as "Python: Bug: Agent initialised from YAML file does not register the response_format and always responds in free text". The
problem a user observed, and its root cause:

**Describe the bug**
I am trying to implement the initialisation of agents from their specifications in YAML files to avoid writing instructions of the agents within the code. To do so I am using the AgentRegistry.create_from_file method. Using this method, when I initialise the ChatCompletionAgent with my defined AzureChatPromptExecutionSettings, the agent does not follow the response_format provided in the settings. Instead it returns the response as free text. However, if I initialise the agent within the code itself, it uses the response_format to structure its response. 

**To Reproduce**
1. _The structure of the workspace_

<img width="125" height="168" alt="Image" src="https://github.com/user-attachments/assets/dddce980-8da4-441b-a4cb-5d5a43aa14e5" />

The goal is to initialise an agent that will use a native python function to crawl the datasets folder and return only the paths of the datasets that are relevant to the request. Example of a request is "Give me the location of all the datasets which contain customer details". Currently the scope is limited to just retrieving the paths of all files in the datasets folder.

2. _Defining the native python function_

The following python function is used 

```
# function to traverse a directory and get the path relevant data files

from typing import List
import os

def get_data_filenames(datasets_directory: str, safe_file_exts: tuple[str] = ('.csv', '.xml', '.txt', '.json')) -> List[str]:
    

    data_files_paths: List[str] = [] # store the paths of all the files                                                     

    # start the traversal
    for dirpath, dirs, files in os.walk(datasets_directory):

        for filename in files:
            filepath = os.path.join(dirpath,filename)

            if filepath.endswith(safe_file_exts):
                data_files_paths.append(filepath)

    return data_files_paths
```

3. _Registering it in a plugin as a kernel function_

A plugin is created with this single function

```
# create the plugin for the file discovery agent 

from semantic_kernel.functions import kernel_function, KernelArguments

class FileDiscoveryPlugin:
    @kernel_function(description="Find the files in the given dictionary")
    async def find_files(self, datasets_directory: Annotated[str, 'the path of the directory where the datasets are present']) -> Annotated[List[str], 'list of paths of the datasets in that directory']:
        "Find the files in the given dictionary"
        return get_data_filenames(datasets_directory)
```

4. _Defining the class that will be used a response_format_

```
from semantic_kernel.kernel_pydantic import KernelBaseModel

## define the class for the output structure of the file discovery agent
class FilesList(KernelBaseModel):
    files_list: Annotated[List[str], "a list of paths of datasets"]
```

5. _Function Invocation Filter to check the execution_

```
## define the function invocation filter - to let us see the outputs

from semantic_kernel.filters import FilterTypes, FunctionInvocationContext
from semantic_kernel.connectors.ai.function_choice_behavior import FunctionChoiceBehavior
from typing import Awaitable, Callable

async def function_invocation_filter(
    context: FunctionInvocationContext,
    next: Callable[[FunctionInvocationContext], Awaitable[None]],
) -> None:
    # this runs before the function is called
    print(f"  ---> Calling Plugin {context.function.plugin_name}.{context.function.name} with arguments `{context.arguments}`")
    # let's await the function call
    await next(context)
    # this runs after our functions has been called
    print(f"  ---> Plugin response from [{context.function.plugin_name}.{context.function.name} is `{context.result}`")
```

6. _Adding the plugin and filter to the kernel_

```
from semantic_kernel import Kernel

kernel = Kernel()

## add the plugin to the kernel
kernel.add_plugin(
    plugin = FileDiscoveryPlugin(),
    plugin_name = "FileDiscoveryPlugin"
)

## add the filter to observe the outputs
kernel.add_filter(FilterTypes.FUNCTION_INVOCATION, function_invocation_filter) 

print(f'plugins listed to the kernel: {kernel.plugins}\n')
print(f'Invocation filters added: {kernel.function_invocation_filters}\n')
```

<img width="732" height="86" alt="Image" src="https://github.com/user-attachments/assets/c5c5a014-402a-4cd9-a1cf-d645ccc192dd" />



7. _Initialising the agents and passing a request_  
  
  a. Using a YAML specs file

The YAML File

```
type: chat_completion_agent
name: FileDiscoveryAgent
template: |
  <message role="system">
    You are an AI agent that searches for files. As the agent, you give the user all the files that are present in the specified folder.
    
    # File search context 
    Folder: {{datasets_directory}}

    Return the paths of all files found to the user.

template_format: semantic-kernel
description: An assistant that gathers the list of files in a given directory.
instructions: You are an AI agent that searches for files. As the agent, you give the user all the files that are present in the specified folder. Return the response in the format that has been given to you.
tools:
  - id: FileDiscoveryPlugin.find_files
    type: function
input_variables:
  - name: datasets_directory
    description: The folder with the datasets.
    is_required: true
```

iniltialising the settings
```
from semantic_kernel.connectors.ai.open_ai import AzureChatPromptExecutionSettings

model_settings = AzureChatPromptExecutionSettings()
model_settings.function_choice_behavior = FunctionChoiceBehavior.Required()
model_settings.temperature = 0.0
model_settings.top_p = 0.0
model_settings.response_format = FilesList # provide the defined class as the format to structure response
```

creating the agent from the YAML file and providing the settings, asking for a response
```
agent: ChatCompletionAgent = await AgentRegistry.create_from_file(
    yaml_path, service = AzureChatCompletion(), kernel=kernel, settings = model_settings, arguments=KernelArguments(datasets_directory="./datasets/")
)

response = await agent.get_response(messages=f"find all the files in ./datasets/")
print(f'response content:{response.message.content}, type: {type(response.message.content)}\n')
```

I get the following 

<img width="472" height="84" alt="Image" src="https://github.com/user-attachments/assets/d91c1ebf-2f2e-4a61-9d20-0a605fd43204" />

I have also tried a few other ways:

Adding the output format to the YAML and not initialising the setting from AzureChatPromptExecutionSettings. I am not sure if I have defined the output structure in the YAML correctly since I could not find documentation of setting a class as the output variable in a YAML specification.

```
type: chat_completion_agent
name: FileDiscoveryAgent
template: |
  <message role="system">
    You are an AI agent that searches for files. As the agent, you give the user all the files that are present in the specified folder.
    
    # File search context 
    Folder: {{datasets_directory}}

    Return the paths of all files found to the user.
   
template_format: semantic-kernel
description: An assistant that gathers the list of files in a given directory.
instructions: You are an AI agent that searches for files. As the agent, you give the user all the files that are present in the specified folder. Return the response in the format that has been given to you.
tools:
  - id: FileDiscoveryPlugin.find_files
    type: function
input_variables:
  - name: datasets_directory
    description: The folder with the datasets.
    is_required: true
output_variable:
  - description: The list of files in the folder
    json_schema: {"files_list": ["path_1", "path_2", "path_3", "path_n"]}
execution_settings:
  default:
    temperature: 0.0
    top_p: 0.0

agent: ChatCompletionAgent = await AgentRegistry.create_from_file(
    yaml_path, service = AzureChatCompletion(), kernel=kernel, settings = model_settings, arguments=KernelArguments(datasets_direc

This same root cause must be fixed before merging.
REVIEW_EOF
