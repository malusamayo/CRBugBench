#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Validation/test/Microsoft.Extensions.Validation.GeneratorTests/ValidationsGenerator.Parsable.cs`:

This pull request introduces the defect later reported as "CanValidateTypeWithParsableProperties test failure". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Describe the bug

I have cloned the repository and ran the test suite from the `src/Validation` folder using:

`build.cmd -test`

One test is failing:

```
Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.CanValidateTypeWithParsableProperties
Assert.Collection() Failure: Item comparison failure
```

### Expected Behavior

The test should pass.

### Steps To Reproduce

Launch the test suite from the `src/Validation` folder using the `build.cmd -test` command.

### Exceptions (if any)

```
Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.CanValidateTypeWithParsableProperties
Assert.Collection() Failure: Item comparison failure\r\n                                                                                         ↓ (pos 1)\r\nCollection: [[\"DateOnlyWithRange\"] = [\"Date must be between 2023-01-01 and 2025-12-31\"], [\"DecimalWithRange\"] = [\"0.1 is not a valid value for Decimal. (Parameter '\"···], [\"TimeOnlyWithRequiredValue\"] = [\"The TimeOnlyWithRequiredValue field is required.\"], [\"TimeSpanWithHourRange\"] = [\"Hours must be between 0 and 12\"], [\"Url\"] = [\"The field Url must be a valid URL.\"], ···]\r\nError:      Assert.Contains() Failure: Item not found in collection\r\n            Collection: [\"0.1 is not a valid value for Decimal. (Parameter '\"···]\r\n            Not found:  \"Amount must be between 0.1 and 100.5\"\r\n            Stack Trace:\r\n              C:\\Projects\\aspnetcore\\src\\Validation\\test\\Microsoft.Extensions.Validation.GeneratorTests\\ValidationsGenerator.Parsable.cs(97,0): at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.<>c.<CanValidateTypeWithParsableProperties>b__7_3(KeyValuePair`2 error)
   at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.<CanValidateTypeWithParsableProperties>b__7_0(Endpoint endpoint, IServiceProvider serviceProvider) in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGenerator.Parsable.cs:line 88
   at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTestBase.VerifyEndpoint(Compilation compilation, String routePattern, Func`3 verifyFunc) in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGeneratorTestBase.cs:line 118
   at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.CanValidateTypeWithParsableProperties() in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGenerator.Parsable.cs:line 65
--- End of stack trace from previous location ---
Output:
| [0.002s] TestLifetime Information: Starting test CanValidateTypeWithParsableProperties at 2025-07-09T10:48:55
| [0.343s] Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests Error: Test threw an exception.
| Xunit.Sdk.CollectionException: Assert.Collection() Failure: Item comparison failure
|                                                                                          ↓ (pos 1)
| Collection: [["DateOnlyWithRange"] = ["Date must be between 2023-01-01 and 2025-12-31"], ["DecimalWithRange"] = ["0.1 is not a valid value for Decimal. (Parameter '"···], ["TimeOnlyWithRequiredValue"] = ["The TimeOnlyWithRequiredValue field is required."], ["TimeSpanWithHourRange"] = ["Hours must be between 0 and 12"], ["Url"] = ["The field Url must be a valid URL."], ···]
| Error:      Assert.Contains() Failure: Item not found in collection
|             Collection: ["0.1 is not a valid value for Decimal. (Parameter '"···]
|             Not found:  "Amount must be between 0.1 and 100.5"
|             Stack Trace:
|               C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGenerator.Parsable.cs(97,0): at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.<>c.<CanValidateTypeWithParsableProperties>b__7_3(KeyValuePair`2 error)
|    at Xunit.Assert.Collection[T](IEnumerable`1 collection, Action`1[] elementInspectors) in /_/src/xunit.assert/Asserts/CollectionAsserts.cs:line 176
|    at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.<CanValidateTypeWithParsableProperties>b__7_0(Endpoint endpoint, IServiceProvider serviceProvider) in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGenerator.Parsable.cs:line 88
|    at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTestBase.VerifyEndpoint(Compilation compilation, String routePattern, Func`3 verifyFunc) in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGeneratorTestBase.cs:line 118
|    at Microsoft.Extensions.Validation.GeneratorTests.ValidationsGeneratorTests.CanValidateTypeWithParsableProperties() in C:\Projects\aspnetcore\src\Validation\test\Microsoft.Extensions.Validation.GeneratorTests\ValidationsGenerator.Parsable.cs:line 65
|    at Xunit.Sdk.TestInvoker`1.<>c__DisplayClass47_0.<<InvokeTestMethodAsync>b__1>d.MoveNext() in /_/src/xunit.execution/Sdk/Frameworks/Runners/TestInvoker.cs:line 259
| --- End of stack trace from previous location ---
|    at Xunit.Sdk.ExecutionTimer.AggregateAsync(Func`1 asyncAction) in /_/src/xunit.execution/Sdk/Frameworks/ExecutionTimer.cs:line 48
|    at Xunit.Sdk.ExceptionAggregator.RunAsync(Func`1 code) in /_/src/xunit.core/Sdk/ExceptionAggregator.cs:line 90
| [0.345s] TestLifetime Information: Finished test CanValidateTypeWithParsableProperties in 0.3436535s
```

### .NET Version

 10.0.100-preview.6.25315.102 (from https://github.com/dotnet/aspnetcore/blob/main/global.json)

This same root cause must be fixed before merging.
REVIEW_EOF
