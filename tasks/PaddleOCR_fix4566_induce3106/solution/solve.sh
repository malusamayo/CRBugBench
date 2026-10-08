#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ppocr/modeling/heads/table_att_head.py`:

This pull request introduces the defect later reported as "[Table structure] Discrepancy between training model and inference model  ". The
problem a user observed, and its root cause:

Hi there,

When I run the training model with the following script and print out the model outputs shape, I get (1,501,30) and (1,501,4).
`python tools/infer_table.py -c './configs/table/table_mv3.yml' -o Global="{'infer_img':'path/to/image', 'pretrained_model':'path/to/model/en_ppocr_mobile_v2.0_table_structure_train/best_accuracy'}"`

But when I run the inference model with `ppstructure.table.predict_structure.TableStructurer` and print out the model outputs shape, I get (1,801,30) and (1,801,4).

The two models gave me different structure predictions and different bounding boxes. The prediction from the training model is obviously wrong. How can I get prediction right for the training model? Thanks.

This same root cause must be fixed before merging.
REVIEW_EOF
