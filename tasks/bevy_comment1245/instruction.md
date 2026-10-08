# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Rich text

**PR description:**

Refer #1222

This takes advantage of [glyph_brush_layout](https://crates.io/crates/glyph_brush_layout)'s `SectionText` API.

Currently the `Text` component has an assumption that there is exactly one section only, so all I've done is create a "sections" API to connect it to glyph_brush_layout's API. I've made as few changes as possible otherwise.

However, I've updated all examples with text in them, including enhancing them with multiple text sections where I thought it made sense.

This is a breaking change, so this will need a changelog entry - I wasn't sure where to put this, so please advise.

We can potentially flatten the API further; see the questions below.

# New API

The new API is as follows:
```rust
// Component
pub struct Text {
    // pub value: String,             // moved to TextSection
    // pub font: Handle<Font>,        // moved to TextSection
    // pub style: TextStyle,          // moved to TextSection
    pub sections: Vec<TextSection>,   // +
    pub alignment: TextAlignment,     // +
}

pub struct TextSection {              // new
    pub value: String,                // +
    pub font: Handle<Font>,           // +
    pub style: TextStyle,             // +
}

pub struct TextStyle {
    pub font_size: f32,
    pub color: Color,
    // pub alignment: TextAlignment,  // moved to Text
}
```

## Questions

It might make sense to either:

1. spread the members of `TextStyle` into `TextSection`, or
2. move `font` from `TextSection` into `TextStyle`

# Example

Example below:

![image](https://user-images.githubusercontent.com/38416468/104604572-76152300-56b8-11eb-892c-19089e5c34bc.png)
_The "Score: " and the "10" have different fonts, font sizes, and colours_

```rust
fn setup(
    commands: &mut Commands,
    mut materials: ResMut<Assets<ColorMaterial>>,
    asset_server: Res<AssetServer>,
) {
    // Add the game's entities to our world
    commands
        // ...
        // scoreboard
        .spawn(TextBundle {
            text: Text {
                sections: vec![
                    TextSection {
                        font: asset_server.load("fonts/FiraSans-Bold.ttf"),
                        value: "Score: ".to_string(),
                        style: TextStyle {
                            color: Color::rgb(0.5, 0.5, 1.0),
                            font_size: 40.0,
                        },
                    },
                    TextSection {
                        font: asset_server.load("fonts/FiraMono-Medium.ttf"),
                        value: "".to_string(),
                        style: TextStyle {
                            color: Color::rgb(0.9, 0.3, 1.0),
                            font_size: 60.0,
                        },
                    },
                ],
                ..Default::default()
            },
            style: Style {
                position_type: PositionType::Absolute,
                position: Rect {
                    top: Val::Px(5.0),
                    left: Val::Px(5.0),
                    ..Default::default()
                },
                ..Default::default()
            },
            ..Default::default()
        });
    // ...
}

fn scoreboard_system(scoreboard: Res<Scoreboard>, mut query: Query<&mut Text>) {
    for mut text in query.iter_mut() {
        text.sections[1].value = scoreboard.score.to_string();
    }
}

```

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
