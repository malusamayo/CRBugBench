#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `OpenRA.Mods.Common/Projectiles/Bullet.cs`:

This pull request introduces the defect later reported as "IndexOutOfRangeException in Bullet.ShouldExplode GetTerrainInfo". The
problem a user observed, and its root cause:

```
Exception of type `System.IndexOutOfRangeException`: Index was outside the bounds of the array.
  at OpenRA.CellLayer`1[T].get_Item (OpenRA.MPos uv) [0x00000] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Map/CellLayer.cs:85 
  at OpenRA.Map.GetTerrainIndex (OpenRA.CPos cell) [0x0004e] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Map/Map.cs:1072 
  at OpenRA.Map.GetTerrainInfo (OpenRA.CPos cell) [0x00000] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Map/Map.cs:1087 
  at OpenRA.Mods.Common.Projectiles.Bullet.ShouldExplode (OpenRA.World world) [0x0013f] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Mods.Common/Projectiles/Bullet.cs:239 
  at OpenRA.Mods.Common.Projectiles.Bullet.Tick (OpenRA.World world) [0x00046] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Mods.Common/Projectiles/Bullet.cs:208 
  at OpenRA.World.<Tick>b__112_1 (OpenRA.Effects.IEffect e) [0x00000] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/World.cs:472 
  at OpenRA.WorldUtils.DoTimed[T] (System.Collections.Generic.IEnumerable`1[T] e, System.Action`1[T] a, System.String text) [0x00015] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/WorldUtils.cs:78 
  at OpenRA.World.Tick () [0x0017b] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/World.cs:472 
  at OpenRA.Game.InnerLogicTick (OpenRA.Network.OrderManager orderManager) [0x001bc] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Game.cs:606 
  at OpenRA.Game.LogicTick () [0x0003e] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Game.cs:632 
  at OpenRA.Game.Loop () [0x000f1] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Game.cs:797 
  at OpenRA.Game.Run () [0x0003c] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Game.cs:838 
  at OpenRA.Game.InitializeAndRun (System.String[] args) [0x00010] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Game.cs:274 
  at OpenRA.Program.Main (System.String[] args) [0x00044] in /home/matthias/Entwicklung/OpenSA/engine/OpenRA.Game/Support/Program.cs:37
```

This same root cause must be fixed before merging.
REVIEW_EOF
