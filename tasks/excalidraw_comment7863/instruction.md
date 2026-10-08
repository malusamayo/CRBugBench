# Code Review Task

You are a maintainer reviewing a pull request to the `excalidraw/excalidraw` repository.

**PR title:** fix: add safe check for arrow points length in tranformToExcalidrawElements

**PR description:**

The diagrams having single arrow points were breaking due to updating the bindings hence I have added a safe check

eg 👇🏻 

```
flowchart LR
    subgraph A
      Alice
    end    
    subgraph B
      Bob -->|How are you?| Alice
    end    
    %% Relationships
    Bob --> |Friendship| B
```

`mermaid-to-excalidraw` outputs the 👇🏻 data which is passed to `transformToExcalidrawElements` and notice the last element of this array has single point `[0, 0]`
```
[
    {
        "id": "B",
        "type": "rectangle",
        "groupIds": [
            "subgraph_group_B"
        ],
        "x": 0,
        "y": 0,
        "width": 166.03125,
        "height": 163,
        "label": {
            "groupIds": [
                "subgraph_group_B"
            ],
            "text": "B",
            "fontSize": 20,
            "verticalAlign": "top"
        }
    },
    {
        "id": "A",
        "type": "rectangle",
        "groupIds": [
            "subgraph_group_A"
        ],
        "x": 364.546875,
        "y": 0,
        "width": 120.265625,
        "height": 114,
        "label": {
            "groupIds": [
                "subgraph_group_A"
            ],
            "text": "A",
            "fontSize": 20,
            "verticalAlign": "top"
        }
    },
    {
        "id": "Alice",
        "type": "rectangle",
        "groupIds": [
            "subgraph_group_A"
        ],
        "x": 389.546875,
        "y": 35,
        "width": 70.265625,
        "height": 44,
        "strokeWidth": 2,
        "label": {
            "groupIds": [
                "subgraph_group_A"
            ],
            "text": "Alice",
            "fontSize": 20
        },
        "link": null
    },
    {
        "id": "Bob",
        "type": "rectangle",
        "groupIds": [
            "subgraph_group_B"
        ],
        "x": 54.76953125,
        "y": 35,
        "width": 56.4921875,
        "height": 44,
        "strokeWidth": 2,
        "label": {
            "groupIds": [
                "subgraph_group_B"
            ],
            "text": "Bob",
            "fontSize": 20
        },
        "link": null
    },
    {
        "id": "Bob_Alice",
        "type": "arrow",
        "groupIds": [],
        "x": 111.262,
        "y": 57,
        "strokeWidth": 2,
        "points": [
            [
                0,
                0
            ],
            [
                272.985,
                0
            ]
        ],
        "label": {
            "text": "How are you?",
            "fontSize": 20,
            "groupIds": []
        },
        "roundness": {
            "type": 2
        },
        "start": {
            "id": "Bob"
        },
        "end": {
            "id": "Alice"
        }
    },
    {
        "id": "Bob_B",
        "type": "arrow",
        "groupIds": [],
        "x": 77.017,
        "y": 79,
        "strokeWidth": 2,
        "points": [
            [
                0,
                0
            ]
        ],
        "label": {
            "text": "Friendship",
            "fontSize": 20,
            "groupIds": []
        },
        "roundness": {
            "type": 2
        },
        "start": {
            "id": "Bob"
        },
        "end": {
            "id": "B"
        }
    }
]
```

## Working environment

The repository is checked out at `/app/excalidraw` at this PR's **base commit**
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
