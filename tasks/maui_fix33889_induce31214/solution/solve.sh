#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Controls/src/Core/Platform/Android/TapAndPanGestureDetector.cs`:

This pull request introduces the defect later reported as "PointerGestureRecognizer does not fire off PointerMove event on Android". The
problem a user observed, and its root cause:

### Description

I am currently seeing that the pointer gesture recognizer does not receive the move event regardless of what element you put it on. On iOS, all the events fire off as expected, however, on Android only the PointerEntered and PointerReleased events are received, the move event is never fired off. If there is a known work around that would be great because we do need to be able to track the position of the pointer in our application. Below is the small amount of code we have that shows us when we run Android, the event doesn't fire off:

```
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="MauiTemplate.Pages.MainPage">

    <Image BackgroundColor="Orange">
        <Image.GestureRecognizers>
            <PointerGestureRecognizer
                PointerPressed="PointerGestureRecognizer_OnPointerPressed"
                PointerMoved="PointerGestureRecognizer_OnPointerMoved"
                PointerReleased="PointerGestureRecognizer_OnPointerReleased"/>
        </Image.GestureRecognizers>
    </Image>

</ContentPage>
```

```
using System.Diagnostics;

namespace MauiTemplate.Pages;

public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();
    }

    private void PointerGestureRecognizer_OnPointerPressed(object? sender, PointerEventArgs e)
    {
        Debug.WriteLine("======");
        Debug.WriteLine("Pressed");
    }

    private void PointerGestureRecognizer_OnPointerMoved(object? sender, PointerEventArgs e)
    {
        Debug.WriteLine("======");
        Debug.WriteLine("Moved");
    }

    private void PointerGestureRecognizer_OnPointerReleased(object? sender, PointerEventArgs e)
    {
        Debug.WriteLine("======");
        Debug.WriteLine("Released");
    }
}
```

If you do this on your machine what you will see is that all the events are received on iOS but on Android there will be no debug log with move showing. From reading the docs in MAUI, it appears this should work, however it does not.

### Steps to Reproduce

1. Create a MAUI app
2. Add an Image to the page
3. Add PointerGestureRecognizer to the image
4. Run on iOS, all logs appear
5. Run on Android, no PointerMove is logged


### Link to public reproduction project repository

_No response_

### Version with bug

10.0.20

### Is this a regression from previous behavior?

Not sure, did not test other versions

### Last version that worked well

Unknown/Other

### Affected platforms

Android

### Affected platform versions

Android 36

### Did you find any workaround?

_No response_

### Relevant log output

```shell

```

This same root cause must be fixed before merging.
REVIEW_EOF
