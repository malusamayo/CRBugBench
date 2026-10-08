#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tools/export_model.py`:

This pull request introduces the defect later reported as "检测模型转inference模型，'use_gpu': False，但仍然转换失败". The
problem a user observed, and its root cause:

你好，在检测模型转inference模型时，已修改det_mv3_db.yml 中'use_gpu': False，但仍然报错，如下所示：
python tools/export_model.py -c configs/det/det_mv3_db.yml -o Global.checkpoints=./ch_lite/det_mv3_db/best_accuracy Global.save_inference_dir=./inference_model/det_db/
2020-05-19 10:29:59,237-INFO: {'Global': {'algorithm': 'DB', 'use_gpu': False, 'epoch_num': 1200, 'log_smooth_window': 20, 'print_batch_step': 2, 'save_model_dir': './output/det_db/', 'save_epoch_step': 200, 'eval_batch_step': 5000, 'train_batch_size_per_card': 16, 'test_batch_size_per_card': 16, 'image_shape': [3, 640, 640], 'reader_yml': './configs/det/det_db_icdar15_reader.yml', 'pretrain_weights': './pretrain_models/MobileNetV3_large_x0_5_pretrained/', 'checkpoints': './ch_lite/det_mv3_db/best_accuracy', 'save_res_path': './output/det_db/predicts_db.txt', 'save_inference_dir': './inference_model/det_db/'}, 'Architecture': {'function': 'ppocr.modeling.architectures.det_model,DetModel'}, 'Backbone': {'function': 'ppocr.modeling.backbones.det_mobilenet_v3,MobileNetV3', 'scale': 0.5, 'model_name': 'large'}, 'Head': {'function': 'ppocr.modeling.heads.det_db_head,DBHead', 'model_name': 'large', 'k': 50, 'inner_channels': 96, 'out_channels': 2}, 'Loss': {'function': 'ppocr.modeling.losses.det_db_loss,DBLoss', 'balance_loss': True, 'main_loss_type': 'DiceLoss', 'alpha': 5, 'beta': 10, 'ohem_ratio': 3}, 'Optimizer': {'function': 'ppocr.optimizer,AdamDecay', 'base_lr': 0.001, 'beta1': 0.9, 'beta2': 0.999}, 'PostProcess': {'function': 'ppocr.postprocess.db_postprocess,DBPostProcess', 'thresh': 0.3, 'box_thresh': 0.7, 'max_candidates': 1000, 'unclip_ratio': 1.5}, 'TrainReader': {'reader_function': 'ppocr.data.det.dataset_traversal,TrainReader', 'process_function': 'ppocr.data.det.db_process,DBProcessTrain', 'num_workers': 8, 'img_set_dir': './train_data/icdar2015/text_localization/', 'label_file_path': './train_data/icdar2015/text_localization/train_icdar2015_label.txt'}, 'EvalReader': {'reader_function': 'ppocr.data.det.dataset_traversal,EvalTestReader', 'process_function': 'ppocr.data.det.db_process,DBProcessTest', 'img_set_dir': './train_data/icdar2015/text_localization/', 'label_file_path': './train_data/icdar2015/text_localization/test_icdar2015_label.txt', 'test_image_shape': [736, 1280]}, 'TestReader': {'reader_function': 'ppocr.data.det.dataset_traversal,EvalTestReader', 'process_function': 'ppocr.data.det.db_process,DBProcessTest', 'single_img_path': None, 'img_set_dir': './train_data/icdar2015/text_localization/', 'label_file_path': './train_data/icdar2015/text_localization/test_icdar2015_label.txt', 'test_image_shape': [736, 1280], 'do_eval': True}}
2020-05-19 10:29:59,238-ERROR: Config use_gpu cannot be set as true while you are using paddlepaddle cpu version !
Please try:
        1. Install paddlepaddle-gpu to run model on GPU
        2. Set use_gpu as false in config file to run model on CPU

This same root cause must be fixed before merging.
REVIEW_EOF
