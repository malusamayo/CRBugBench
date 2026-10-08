#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/common/Elsa.Mediator/HostedServices/BackgroundCommandSenderHostedService.cs`:

This pull request introduces the defect later reported as "Memory Leak while dispatching workflows". The
problem a user observed, and its root cause:

## Description
In my usecase I dispatch a very hug number of workflows and I recognized an increasing memory usage.

## Steps to Reproduce
Create a workflow which will be dispatched very often (my test dispatches about 200 workflows per second)
After about 1 minute I stop dispatching and wait another minute to be sure that all queues are empty.

## Expected Behavior
The memory usage should be nearly the same es at startup time.

## Actual Behavior
The memory is higher than expected.
Analysing the heap memory shows that there are a hugh number of CancellationTokenSources.
![Image](https://github.com/user-attachments/assets/22cae843-d3e1-4485-98f0-1f43f3444829)
![Image](https://github.com/user-attachments/assets/dbc72033-5040-44d0-9a50-1cad91601e9d)

## Environment
- **Elsa Package Version**: 3.3.2
- **Operating System**: Windows 10

## Troubleshooting Attempts
I created my own {Custom}BackgroundCommandSenderHostedService and changed the following code:
From
```
private async Task ReadOutputAsync(Channel<ICommand> output, CancellationToken cancellationToken)
{
	await foreach (var command in output.Reader.ReadAllAsync(cancellationToken))
	{
		try
		{
			using var scope = _scopeFactory.CreateScope();
			var commandSender = scope.ServiceProvider.GetRequiredService<ICommandSender>();

			await commandSender.SendAsync(command, CommandStrategy.Default, cancellationToken);
		}
		catch (Exception e)
		{
			_logger.LogError(e, "An unhandled exception occured while processing the queue");
		}
	}
}
```

To
```
private async Task ReadOutputAsync(Channel<ICommand> output, CancellationToken cancellationToken)
{
	await foreach (var command in output.Reader.ReadAllAsync(cancellationToken))
	{
		try
		{
			using var scope = _scopeFactory.CreateScope();
			var commandSender = scope.ServiceProvider.GetRequiredService<ICommandSender>();

			await commandSender.SendAsync(command, CommandStrategy.Default, CancellationToken.None);
		}
		catch (Exception e)
		{
			_logger.LogError(e, "An unhandled exception occured while processing the queue");
		}
	}
}
```

after that it gives this result:
![Image](https://github.com/user-attachments/assets/f6bfc8e8-b6f3-4849-867f-94e5791b922f)

Any idea whats the problem here or how to fix this?
The strange thing is that there are no instances if I try to debug it.
The BackgroundCommandSenderHostedService has 4 items inside the _output variable and if I check the `UnboundedChannel` inside them the _items lists are empty and I'm also not able to find a big number of AsyncOperation items.
[UnboundedChannel source code](https://github.com/dotnet/runtime/blob/main/src/libraries/System.Threading.Channels/src/System/Threading/Channels/UnboundedChannel.cs)

This same root cause must be fixed before merging.
REVIEW_EOF
