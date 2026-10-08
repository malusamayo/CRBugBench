#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `osu.Game.Rulesets.Osu/Edit/Blueprints/Sliders/SliderSelectionBlueprint.cs`:

This pull request introduces the defect later reported as "Crash when shift-rightclick deleting a slider which hasn't yet been selected.". The
problem a user observed, and its root cause:

**Describe the crash:** 
The client crashes when quick deleting (shift-rightclicking) a non-selected slider blueprint if the slider hasn't been selected since being created or loaded. It works correctly if the slider has been selected and then deselected at any point.

**Screenshots or videos showing encountered issue:** 

**osu!lazer version:**
Latest master. 

**Logs:**
Relevant part of runtime.log:
```
2020-11-06 21:59:45 [debug]: MouseDownEvent(Right) handled by OsuBlueprintContainer.
2020-11-06 21:59:46 [verbose]: Unhandled exception has been denied .
2020-11-06 21:59:46 [error]: An unhandled error has occurred.
2020-11-06 21:59:46 [error]: System.NullReferenceException: Object reference not set to an instance of an object.
2020-11-06 21:59:46 [error]: at osu.Game.Rulesets.Osu.Edit.Blueprints.Sliders.SliderSelectionBlueprint.HandleQuickDeletion() in E:\dev\osuFork\osu\osu.Game.Rulesets.Osu\Edit\Blueprints\Sliders\SliderSelectionBlueprint.cs:line 78
2020-11-06 21:59:46 [error]: at osu.Game.Screens.Edit.Compose.Components.SelectionHandler.handleQuickDeletion(SelectionBlueprint blueprint) in E:\dev\osuFork\osu\osu.Game\Screens\Edit\Compose\Components\SelectionHandler.cs:line 241
2020-11-06 21:59:46 [error]: at osu.Game.Screens.Edit.Compose.Components.SelectionHandler.HandleSelectionRequested(SelectionBlueprint blueprint, InputState state) in E:\dev\osuFork\osu\osu.Game\Screens\Edit\Compose\Components\SelectionHandler.cs:line 227
2020-11-06 21:59:46 [error]: at osu.Game.Screens.Edit.Compose.Components.BlueprintContainer.beginClickSelection(MouseButtonEvent e) in E:\dev\osuFork\osu\osu.Game\Screens\Edit\Compose\Components\BlueprintContainer.cs:line 306
2020-11-06 21:59:46 [error]: at osu.Game.Screens.Edit.Compose.Components.BlueprintContainer.OnMouseDown(MouseDownEvent e) in E:\dev\osuFork\osu\osu.Game\Screens\Edit\Compose\Components\BlueprintContainer.cs:line 119
2020-11-06 21:59:46 [error]: at System.Linq.Enumerable.TryGetFirst[TSource](IEnumerable`1 source, Func`2 predicate, Boolean& found)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.ButtonEventManager`1.PropagateButtonEvent(IEnumerable`1 drawables, UIEvent e)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.MouseButtonEventManager.HandleButtonDown(InputState state, List`1 targets)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.ButtonEventManager`1.handleButtonDown(InputState state)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.InputManager.HandleMouseButtonStateChange(ButtonStateChangeEvent`1 e)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.UserInputManager.HandleInputStateChange(InputStateChangeEvent inputStateChange)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.StateChanges.ButtonInput`1.Apply(InputState state, IInputStateChangeHandler handler)
2020-11-06 21:59:46 [error]: at osu.Framework.Input.InputManager.Update()
2020-11-06 21:59:46 [error]: at osu.Framework.Input.PassThroughInputManager.Update()
2020-11-06 21:59:46 [error]: at osu.Framework.Graphics.Drawable.UpdateSubTree()
2020-11-06 21:59:46 [error]: at osu.Framework.Graphics.Containers.CompositeDrawable.UpdateSubTree()
2020-11-06 21:59:46 [error]: at osu.Framework.Platform.GameHost.UpdateFrame()
2020-11-06 21:59:46 [error]: at osu.Framework.Threading.GameThread.ProcessFrame()
2020-11-06 21:59:46 [debug]: Focus changed from nothing to NotificationOverlay.
```

This same root cause must be fixed before merging.
REVIEW_EOF
