#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `OpenRA.Mods.Common/Traits/Buildings/Reservable.cs`:

This pull request introduces the defect later reported as "A crash in Reservable, line 89". The
problem a user observed, and its root cause:

```
OpenRA engine version f41aa12
Shattered Paradise mod version SP-Playtest-20201021
on map 9e1cb657d4a7082f063c097d34c1b0f20b570e6a (Way to Uganda by Morton).
Date: 2020-11-01 08:46:46Z
Operating System: Windows (Microsoft Windows NT 6.2.9200.0)
Runtime Version: .NET CLR 4.0.30319.42000
Exception of type `System.NullReferenceException`: Object reference not set to an instance of an object.
   at OpenRA.Mods.Common.Traits.Reservable.<>c__DisplayClass8_0.<UnReserve>b__0() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Mods.Common\Traits\Buildings\Reservable.cs: 89
   at OpenRA.Mods.Common.Activities.AttackMoveActivity.Tick(Actor self) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Mods.Common\Activities\Move\AttackMoveActivity.cs: 80
   at OpenRA.Activities.Activity.TickOuter(Actor self) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Activities\Activity.cs: 120
   at OpenRA.Traits.ActivityUtils.RunActivity(Actor self, Activity act) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Traits\ActivityUtils.cs: 35
   at OpenRA.Actor.Tick() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Actor.cs: 267
   at OpenRA.World.Tick() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\World.cs: 466
   at OpenRA.Game.InnerLogicTick(OrderManager orderManager) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Game.cs: 606
   at OpenRA.Game.LogicTick() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Game.cs: 632
   在 OpenRA.Game.Loop() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Game.cs: 797
   at OpenRA.Game.Run() in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Game.cs: 838
   at OpenRA.Game.InitializeAndRun(String[] args) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Game.cs: 274
   at OpenRA.Program.Main(String[] args) in D:\work\Projects\Github\shattered-paradise-sdk-mirror\engine\OpenRA.Game\Support\Program.cs: 33
```

This same root cause must be fixed before merging.
REVIEW_EOF
