#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Microsoft.ML.Dnn/DnnRetrainTransform.cs`:

This pull request introduces the defect later reported as "[DNN Training] Failed save model in Microsoft.ML.Transforms.DnnTransformer.SaveModel". The
problem a user observed, and its root cause:

### System information

- **OS version/distro**: maxOS 10.14.6
- **.NET Version (eg., dotnet --info)**: 3.0.100-preview9-014004

### Issue

- **What did you do?**

  * Use `RetrainDnnModel` for training regression-based deep-neural-network model
  * Try to save trained model

- **What happened?**

Application throw unhandled exception: System.ArgumentNullException and crash

- **What did you expect?**

We could save trained model

### Source code / logs

```
Unhandled exception. System.ArgumentNullException: Value cannot be null. (Parameter 'value')
   at System.IO.BinaryWriter.Write(String value)
   at Microsoft.ML.Transforms.DnnTransformer.SaveModel(ModelSaveContext ctx)
   at Microsoft.ML.Data.RowToRowTransformerBase.Microsoft.ML.ICanSaveModel.Save(ModelSaveContext ctx)
   at Microsoft.ML.ModelSaveContext.SaveModel[T](RepositoryWriter rep, T value, String path)
   at Microsoft.ML.ModelOperationsCatalog.Save(ITransformer model, DataViewSchema inputSchema, Stream stream)
   at Microsoft.ML.ModelOperationsCatalog.Save(ITransformer model, DataViewSchema inputSchema, String filePath)
   at VoiceConversionStarter.Console.Program.Train(TrainMcapOptions opts) in /Users/yamachu/Projects/github.com/yamachu/VoiceConversionStarter/VoiceConversionStarter.Console/Program.cs:line 100
   at VoiceConversionStarter.Console.Program.<>c.<Main>b__2_0(TrainMcapOptions opts) in /Users/yamachu/Projects/github.com/yamachu/VoiceConversionStarter/VoiceConversionStarter.Console/Program.cs:line 118
   at CommandLine.ParserResultExtensions.MapResult[TSource,TResult](ParserResult`1 result, Func`2 parsedFunc, Func`2 notParsedFunc)
   at VoiceConversionStarter.Console.Program.Main(String[] args) in /Users/yamachu/Projects/github.com/yamachu/VoiceConversionStarter/VoiceConversionStarter.Console/Program.cs:line 116
```

I think this issue is not to check null in this line

https://github.com/dotnet/machinelearning/blob/8d51eee8047842ae72f5521bd55a9bec51460859/src/Microsoft.ML.Dnn/DnnTransform.cs#L1118-L1119

That field in my trained model is null
<img width="548" alt="スクリーンショット 2019-09-09 1 21 42" src="https://user-images.githubusercontent.com/1955233/64491256-3e66c180-d2a1-11e9-967d-5501d6315d61.png">

full source code: https://github.com/yamachu/VoiceConversionStarter/tree/pkg-update

This same root cause must be fixed before merging.
REVIEW_EOF
