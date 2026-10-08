#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/System.Management.Automation/engine/parser/TypeInferenceVisitor.cs`:

This pull request introduces the defect later reported as "PS v7.4.1 and v7.5.0-preview.1 is crashing on tab completion [not a PSReadLine bug]". The
problem a user observed, and its root cause:

### Prerequisites

- [X] Write a descriptive title.
- [X] Make sure you are able to repro it on the [latest released version](https://github.com/PowerShell/PowerShell/releases)
- [X] Search the existing issues.
- [X] Refer to the [FAQ](https://github.com/PowerShell/PowerShell/blob/master/docs/FAQ.md).
- [X] Refer to [Differences between Windows PowerShell 5.1 and PowerShell](https://learn.microsoft.com/powershell/scripting/whats-new/differences-from-windows-powershell).

### Steps to reproduce

1. Start new PowerShell session (without profile):
`pwsh -nop`
2. Type following, and press `TAB` after `Proc`:
`Get-Process | Sort-Object -Property {switch ($_.Proc`

**PowerShell will crash.**

- It happens on PowerShell **7.4.1** and **7.5.0-preview.1**.
- It's not a **PSReadLine** issue (I have removed **PSReadLine** from system or user module paths).
- This is not happening on PowerShell **5.1**


### Expected behavior

```console
Property completion should not crash PowerShell.
```


### Actual behavior

```console
PowerShell is crashing.
```


### Stack trace

```console
Repeat 18383 times:
--------------------------------
   at System.Management.Automation.TypeInferenceVisitor.InferTypesFrom(System.Management.Automation.Language.MemberExpressionAst)
   at System.Management.Automation.TypeInferenceVisitor.InferTypeFrom(System.Management.Automation.Language.VariableExpressionAst, System.Collections.Generic.List`1<System.Management.Automation.PSTypeName>)
   at System.Management.Automation.TypeInferenceVisitor.System.Management.Automation.Language.ICustomAstVisitor.VisitVariableExpression(System.Management.Automation.Language.VariableExpressionAst)
   at System.Management.Automation.TypeInferenceVisitor.GetExpressionType(System.Management.Automation.Language.ExpressionAst, Boolean)
--------------------------------
   at System.Management.Automation.TypeInferenceVisitor.InferTypesFrom(System.Management.Automation.Language.MemberExpressionAst)
   at System.Management.Automation.TypeInferenceVisitor.InferTypeFrom(System.Management.Automation.Language.VariableExpressionAst, System.Collections.Generic.List`1<System.Management.Automation.PSTypeName>)
   at System.Management.Automation.TypeInferenceVisitor.System.Management.Automation.Language.ICustomAstVisitor.VisitVariableExpression(System.Management.Automation.Language.VariableExpressionAst)
   at System.Management.Automation.AstTypeInference.InferTypeOf(System.Management.Automation.Language.Ast, System.Management.Automation.TypeInferenceContext, System.Management.Automation.TypeInferenceRuntimePermissions)
   at System.Management.Automation.CompletionCompleters.CompleteMember(System.Management.Automation.CompletionContext, Boolean, Int32 ByRef)
   at System.Management.Automation.CompletionAnalysis.GetResultForIdentifier(System.Management.Automation.CompletionContext, Int32 ByRef, Int32 ByRef)
   at System.Management.Automation.CompletionAnalysis.GetResultHelper(System.Management.Automation.CompletionContext, Int32 ByRef, Int32 ByRef)
   at System.Management.Automation.CompletionAnalysis.GetResults(System.Management.Automation.PowerShell, Int32 ByRef, Int32 ByRef)
   at System.Management.Automation.CommandCompletion.CompleteInputImpl(System.Management.Automation.Language.Ast, System.Management.Automation.Language.Token[], System.Management.Automation.Language.IScriptPosition, System.Collections.Hashtable)
   at DynamicClass.CallSite.Target(System.Runtime.CompilerServices.Closure, System.Runtime.CompilerServices.CallSite, System.Type, System.String, Int32, System.Collections.Hashtable)
   at System.Management.Automation.Interpreter.DynamicInstruction`5[[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.Int32, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]].Run(System.Management.Automation.Interpreter.InterpretedFrame)
   at System.Management.Automation.Interpreter.EnterTryCatchFinallyInstruction.Run(System.Management.Automation.Interpreter.InterpretedFrame)
   at System.Management.Automation.Interpreter.EnterTryCatchFinallyInstruction.Run(System.Management.Automation.Interpreter.InterpretedFrame)
   at System.Management.Automation.Interpreter.EnterTryCatchFinallyInstruction.Run(System.Management.Automation.Interpreter.InterpretedFrame)
   at System.Management.Automation.Interpreter.Interpreter.Run(System.Management.Automation.Interpreter.InterpretedFrame)
   at System.Management.Automation.Interpreter.LightLambda.RunVoid1[[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]](System.__Canon)
   at System.Management.Automation.PSScriptCmdlet.RunClause(System.Action`1<System.Management.Automation.Language.FunctionContext>, System.Object, System.Object)
   at System.Management.Automation.CommandProcessorBase.Complete()
   at System.Management.Automation.CommandProcessorBase.DoComplete()
   at System.Management.Automation.Internal.PipelineProcessor.DoCompleteCore(System.Management.Automation.CommandProcessorBase)
   at System.Management.Automation.Internal.PipelineProcessor.SynchronousExecuteEnumerate(System.Object)
   at System.Management.Automation.Runspaces.LocalPipeline.InvokeHelper()
   at System.Management.Automation.Runspaces.LocalPipeline.InvokeThreadProc()
   at System.Management.Automation.Runspaces.LocalPipeline.StartPipelineExecution()
   at System.Management.Automation.Runspaces.PipelineBase.CoreInvoke(System.Collections.IEnumerable, Boolean)
   at System.Management.Automation.Runspaces.PipelineBase.Invoke(System.Collections.IEnumerable)
   at System.Management.Automation.PowerShell+Worker.ConstructPipelineAndDoWork(System.Management.Automation.Runspaces.Runspace, Boolean)
   at System.Management.Automation.PowerShell.CoreInvokeHelper[[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]](System.Management.Automation.PSDataCollection`1<System.__Canon>, System.Management.Automation.PSDataCollection`1<System.__Canon>, System.Management.Automation.PSInvocationSettings)
   at System.Management.Automation.PowerShell.CoreInvoke[[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]](System.Management.Automation.PSDataCollection`1<System.__Canon>, System.Management.Automation.PSDataCollection`1<System.__Canon>, System.Management.Automation.PSInvocationSettings)
   at System.Management.Automation.PowerShell.Invoke(System.Collections.IEnumerable, System.Management.Automation.PSInvocationSettings)
   at System.Management.Automation.CommandCompletion.CallScriptWithStringParameterSet(System.String, Int32, System.Collections.Hashtable, System.Management.Automation.PowerShell)
   at System.Management.Automation.CommandCompletion.CompleteInput(System.String, Int32, System.Collections.Hashtable, System.Management.Automation.PowerShell)
   at Microsoft.PowerShell.PSConsoleReadLine+<>c__DisplayClass33_0.<Microsoft.PowerShell.Internal.IPSConsoleReadLineMockableMethods.CompleteInput>b__0()
   at PlatformWindows.CallPossibleExternalApplication[[System.__Canon, System.Private.CoreLib, Version=8.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]](System.Func`1<System.__Canon>)
   at Microsoft.PowerShell.PSConsoleReadLine.CallPossibleExternalAp

This same root cause must be fixed before merging.
REVIEW_EOF
