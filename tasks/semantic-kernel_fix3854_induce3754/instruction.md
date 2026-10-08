# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/semantic-kernel` repository.

**PR title:** .Net: Pass Kernel to connectors and implement automatic OpenAI function calling (#3754)

**PR description / commit message:**

.Net: Pass Kernel to connectors and implement automatic OpenAI function calling (#3754)

Closes https://github.com/microsoft/semantic-kernel/issues/3687
Closes https://github.com/microsoft/semantic-kernel/issues/2932

This PR includes three commits:

**Commit 1**: Simply updates XML comments for Kernel arguments to
standardize them.

**Commit 2**: Updates the connector interfaces (e.g. IChatCompletion) to
accept an optional Kernel argument. It's passed through everywhere, but
the actual connector implementations largely ignore it, since they don't
need anything from it right now.

**Commit 3**: Updates the {Azure} OpenAI connector to support automatic
function calling, whether those functions are explicitly specified in
OpenAIPromptExecutionSettings or are implicitly available via the passed
in Kernel. The behavior is opt-in, via a revised setting on the
OpenAIPromptExecutionSettings class. Rather than just specifying a
string (which had been "auto", "none" or a specific function name), this
now exposes a property of a new type FunctionCallBehavior, which can be
set to various instances to achieve the desired results:
- FunctionCallBehavior.EnableKernelFunctions - the functions in the
provided kernel will be sent but won't be automatically invoked if
requested
- FunctionCallBehavior.AutoInvokeKernelFunctions - the functions in the
provided kernel will be sent and will be automatically invoked if
requested
- FunctionCallBehavior.EnableFunctions(functionsList, autoInvoke) - the
functions specified will be sent and whether they'll be automatically
invoked is determined by the autoInvoke argument and by whether they're
available in the provided kernel
- FunctionCallBehavior.RequireFunction(function, autoInvoke) - the
specified function will be sent to the service as a request to function
call it

The auto-invoke behavior is wired up based on whether autoInvoke is
true. The FunctionCallBehavior.AutoInvokeKernelFunctions can also be
opted-into in a service-agnostic manner by setting a named property in
the base PromptExecutionSettings class's dictionary; future service
implementations can respect that as well if they either have a built-in
notion of function calling (which some other LLMs do) or if we want to
simulate it with a planner baked into the connector implementation.

Please review this both for my API choices and for implementation
details. @RogerBarreto, in particular I'd appreciate it if you could
look at how streaming is handled. @gitri-ms, I'd appreciate it if you
could review the function calling APIs and implementation support.

With all of this, this is now the "Hello, world" of function calling:
```C#
Kernel kernel = new KernelBuilder()
    .WithOpenAIChatCompletion("gpt-3.5-turbo-1106", apiKey)
    .ConfigurePlugins(plugins => plugins.AddPluginFromObject<TimePlugin>())
    .Build();

OpenAIPromptExecutionSettings settings = new() { FunctionCallBehavior = FunctionCallBehavior.AutoInvokeKernelFunctions };
Console.WriteLine(await kernel.InvokePromptAsync("What is the current time?", settings));
```

## Working environment

The repository is checked out at `/app/semantic-kernel` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
