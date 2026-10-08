#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/modules/Elsa.Workflows.Api/Serialization/ArgumentJsonConverter.cs`:

This pull request introduces the defect later reported as "[BUG] Unexpected behavior of custom variable type in the Elsa Designer". The
problem a user observed, and its root cause:

## Description
Edit the custom object data variable in the elsa Designer which is of array type, Variable shows "Type" as "Object" in place of Custom Variable Type.

## Steps to Reproduce


1. **Detailed Steps**: 
 a.  Created a custom activity as below.
  ```
public class VehicleActivity : CodeActivity<IList<VehicleData>>
{
    [Input(
        Description = "The content type to use when sending the request.", UIHint = InputUIHints.DropDown, UIHandlers = [typeof(VehicleUIHandler), typeof(RefreshUIHandler)]
    )]
    public Input<string> Brand { get; set; } = default!;
    [Output]
    public IList<VehicleData> Output { get; set; } = new List<VehicleData>();

    protected override async ValueTask ExecuteAsync(ActivityExecutionContext context)
    {
        List<VehicleData> lstRuntimeData = new List<VehicleData>();


        VehicleData _data = new VehicleData();
        _data.ValueNumeric = 10;
        _data.ValueString = "BMW";
        lstRuntimeData.Add(_data);


        _data.ValueNumeric = 11;
        _data.ValueString = "Ford";
        lstRuntimeData.Add(_data);

        Output = lstRuntimeData;
        Result.Set(context, Output);
        await context.CompleteActivityAsync();
    }
}

```
b. Register the Variable Type as below in the Program.cs file.
```
 elsa.UseWorkflowManagement(management =>
 { management.AddVariableType<VehicleData>("VehicleData");
 });
 elsa.AddTypeAlias<VehicleData>(nameof(VehicleData));
```
c. Register the activity.
`elsa.AddActivity<VehicleActivity>();`

d. In the Workflow designer, "VARIABLES" tab, Add variable with Type "VahicleData" and Is array : Checked and Click "OK".

![Image](https://github.com/user-attachments/assets/740a744e-fd8f-44f3-a169-d5e4b8bbb5bc)

e. Open the same Variable in the Edit mode and Observe the "Type" and "Is array" : unselected. Also variable type is exposing the outside world.

![Image](https://github.com/user-attachments/assets/420e7f6e-7b7b-4e02-b5f6-f64fca70516d)

![Image](https://github.com/user-attachments/assets/6eda001e-1d01-4321-8f5e-70eb7257e727

3. **Reproduction Rate**: "every time"

## Expected Behavior
If Variable if array type then it should be selected same in the Edit mode too.

## Actual Behavior
If any variable is selected as "Is array" type then in the edit mode if changes to "Type" as "Object" and "Is array" is unselected.

## Screenshots

![Image](https://github.com/user-attachments/assets/537fff60-6c36-4550-a284-87c613ba48aa)

## Environment
- **Elsa Package Version**: Elsa RC8/3.3/3.3.1
- **Operating System**: Windows
- **Browser and Version**: Chrome

This same root cause must be fixed before merging.
REVIEW_EOF
