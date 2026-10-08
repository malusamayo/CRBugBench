#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `api/core/tools/utils/workflow_configuration_sync.py` (around line 33): Sorry for that, I forgot that there are could be more than one end node. 
If there's more than one end node, we should:
1. add collect all end nodes' output variables
2. if there's a variable with the same name, we should overwrite it with the last one. We could write the code like this:
```python
    @classmethod
    def get_workflow_graph_output(cls, graph: Mapping[str, Any]) -> Sequence[OutputVariableEntity]:
        """
        get workflow graph output
        """
        nodes = graph.get("nodes", [])
        outputs_by_variable: dict[str, OutputVariableEntity] = {}
        variable_order: list[str] = []

        for node in nodes:
            if node.get("data", {}).get("type") != "end":
                continue

            for output in node.get("data", {}).get("outputs", []):
                entity = OutputVariableEntity.model_validate(output)
                variable = entity.variable

                if variable not in variable_order:
                    variable_order.append(variable)

                # Later end nodes override duplicated variable definitions.
                outputs_by_variable[variable] = entity

        return [outputs_by_variable[variable] for variable in variable_order]
```
REVIEW_EOF
