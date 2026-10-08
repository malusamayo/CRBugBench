#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Core/src/Handlers/DatePicker/DatePickerHandler.Android.cs`:

This pull request introduces the defect later reported as "[Android] DatePicker Graphical Bug". The
problem a user observed, and its root cause:

### Description

Date picker have problem with showing correct selected Date. Date picker showing wrong selected date when we go to next month.

Example:
If date binding is set to todays date (19.11), and we open date picker it will shows 19.11 what is okey, but if we go to next month it will show that 19.12 is selected what is incorrect. This is just graphical issue, binding is not changing.

I tested it on .net8 and .net9 and on both problem exsit.

Example on video (When I started clicking like monkey problem disappeared lol)

https://github.com/user-attachments/assets/85418be9-5904-4ca1-a1cc-e0b08f6708b5

### Steps to Reproduce

1. Crate new MAUI APP
2. Add ViewModel with 3 observable properties: Date (Set for date today), MaxDate (Today + 60 days), MinDate(Today - 60days)
3. Set this VM as BindingContext for MainPage
4. Add DatePicker with these bindings to MainPage
5. Run App -> Select DatePicker -> Go to next month
Then there should be selected our date and same date in next month

### Link to public reproduction project repository

https://github.com/michalpobuta/DatePickerIssue

### Version with bug

9.0.10 SR1

### Is this a regression from previous behavior?

No, this is something new

### Last version that worked well

Unknown/Other

### Affected platforms

Android

### Affected platform versions

Android 14

### Did you find any workaround?

```c#
public partial class CustomDatePickerHandler
{
    private static readonly DateTime _unixTimeBeginning = new (1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
    private readonly TimeSpan _clickThrottle = TimeSpan.FromMilliseconds(500);
    private DateTime _lastClickTime = DateTime.MinValue;

    public void Show()
    {
        ShowDatePickerPopup();
    }

    protected override void ConnectHandler(MauiDatePicker platformView)
    {
        platformView.Touch += OnTouch;
        base.ConnectHandler(platformView);
    }

    protected override void DisconnectHandler(MauiDatePicker platformView)
    {
        platformView.Touch -= OnTouch;
        base.DisconnectHandler(platformView);
    }

    private void OnTouch(object? sender, View.TouchEventArgs e)
    {
        if (e.Event is not { } motionEvent)
        {
            return;
        }

        e.Handled = true;

        if (motionEvent.Action != MotionEventActions.Up
            && motionEvent.Action != MotionEventActions.PointerUp)
        {
            return;
        }

        if (DateTime.Now < _lastClickTime + _clickThrottle)
        {
            return;
        }

        ShowDatePickerPopup();
    }

    private void ShowDatePickerPopup()
    {
        _lastClickTime = DateTime.Now;

        var datePickerDialog = new DatePickerDialog(Context, OnDateSet, VirtualView.Date.Year, VirtualView.Date.Month - 1, VirtualView.Date.Day);
        datePickerDialog.DatePicker.MinDate = (long)(VirtualView.MinimumDate.Date.ToUniversalTime() - _unixTimeBeginning).TotalMilliseconds;
        datePickerDialog.DatePicker.MaxDate = (long)(VirtualView.MaximumDate.Date.ToUniversalTime() - _unixTimeBeginning).TotalMilliseconds;

        datePickerDialog.Show();
    }

    private void OnDateSet(object? sender, DatePickerDialog.DateSetEventArgs args)
    {
        VirtualView.Date = args.Date;
    }
}
```


### Relevant log output

```shell

```

This same root cause must be fixed before merging.
REVIEW_EOF
