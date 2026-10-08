#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty_terminal/src/ansi.rs`:

This pull request introduces the defect later reported as "problems with OSC 4 and 104". The
problem a user observed, and its root cause:

[Documentation claims that OSC 4 and OSC 104 are supported](https://github.com/alacritty/alacritty/blob/master/docs/escape_support.md). However, testing reveals some issues.

If the OSC is fully supported, we should be able to query the state of colors. Here's a working query using OSC 11:
```
> echo -ne '\e]11;?\a'; cat
^[]11;rgb:ffff/ffff/ffff^G^C⏎  
```
That tells me I have a white background.

Attempting to learn the state of a color in my color palette using OSC 4 does not work, however:
```
> echo -ne '\e]4;1;?\a'; cat
^C⏎ 
```
No information is returned. And in the log, we see:
> [2021-10-13 11:37:43.348998800] [DEBUG] [alacritty_terminal] [unhandled osc_dispatch]: [['4',],['1',],['?',],] at line 947

Strangely, we are able to change the colors with OSC 4:
```
> printf '\e]4;3;#490101\a'
```
That sets my dark yellow to a dark red, easy to see with e.g. `neofetch`.

However, attempting to undo this with OSC 104 does not work:
```
> printf '\e]104;\a'
```
My yellow remains red. The log reports:
> [2021-10-13 11:45:18.472954361] [DEBUG] [alacritty_terminal] [unhandled osc_dispatch]: [['1','0','4',],[],] at line 947

Using a different ending has no effect on results:
```
> echo -ne '\e]11;?\e\\'; cat
^[]11;rgb:ffff/ffff/ffff^[\^C⏎     
> echo -ne '\e]4;1;?\e\\'; cat
^C⏎
```

I should be able to query my color palette with OSC 4, and reset my color palette using OSC 104. Currently I can only use OSC 4 to change colors. The above commands work fine in other shells such as iTerm2 or Foot. Similar commands for OSC 10, 11, 110, and 111 all work in Alacritty as expected.

### System

OS: macOS Catalina 10.15.7
Version: alacritty 0.9.0 (fed349a)

OS: Manjaro ARM Linux
Version: alacritty 0.10.0-dev (b6e05d2d)
DE: Wayland, sway

### Logs

> alacritty -vv
Created log file at "/tmp/Alacritty-25654.log"
[2021-10-13 11:36:58.858691035] [INFO ] [alacritty] Welcome to Alacritty
[2021-10-13 11:36:58.858972769] [INFO ] [alacritty] Configuration files loaded from:
                                                      "/home/nelson/.config/alacritty/alacritty.yml"
[2021-10-13 11:36:58.900859460] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Regular, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:36:58.910606092] [DEBUG] [alacritty] Estimated DPR: 1
[2021-10-13 11:36:58.910720127] [DEBUG] [alacritty] Estimated window size: None
[2021-10-13 11:36:58.910755125] [DEBUG] [alacritty] Estimated cell size: 9 x 20
[2021-10-13 11:36:59.019037732] [INFO ] [alacritty] Device pixel ratio: 1
[2021-10-13 11:36:59.049712562] [INFO ] [alacritty] Initializing glyph cache...
[2021-10-13 11:36:59.054074182] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Regular, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:36:59.063504963] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Bold, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:36:59.073139607] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Italic, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:36:59.082763169] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Bold Italic, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:36:59.430697721] [INFO ] [alacritty] ... finished initializing glyph cache in 0.380882498s
[2021-10-13 11:36:59.430961080] [INFO ] [alacritty] Cell size: 9 x 20
[2021-10-13 11:36:59.431031076] [INFO ] [alacritty] Padding: 4 x 10
[2021-10-13 11:36:59.431070157] [INFO ] [alacritty] Width: 800, Height: 600
[2021-10-13 11:36:59.434250888] [INFO ] [alacritty] PTY dimensions: 29 x 88
[2021-10-13 11:36:59.452195504] [INFO ] [alacritty] Initialisation complete
[2021-10-13 11:36:59.481600616] [DEBUG] [alacritty_terminal] New num_cols is 105 and num_lines is 51
[2021-10-13 11:36:59.490114743] [INFO ] [alacritty] Padding: 5 x 7
[2021-10-13 11:36:59.490217112] [INFO ] [alacritty] Width: 956, Height: 1035
[2021-10-13 11:36:59.645425319] [DEBUG] [alacritty_terminal] [unhandled osc_dispatch]: [['5','0',],['c','o','l','o','r','s','=','l','i','g','h','t',],] at line 947
[2021-10-13 11:37:05.464752222] [DEBUG] [crossfont] Loaded Face Face { ft_face: Font Face: Regular, load_flags: TARGET_LIGHT, render_mode: "Normal", lcd_filter: 1 }
[2021-10-13 11:37:43.348998800] [DEBUG] [alacritty_terminal] [unhandled osc_dispatch]: [['4',],['1',],['?',],] at line 947
[2021-10-13 11:45:18.472954361] [DEBUG] [alacritty_terminal] [unhandled osc_dispatch]: [['1','0','4',],[],] at line 947

This same root cause must be fixed before merging.
REVIEW_EOF
