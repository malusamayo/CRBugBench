#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ppstructure/recovery/table_process.py`:

This pull request introduces the defect later reported as "PPstructure 表格识别错误". The
problem a user observed, and its root cause:

请提供下述完整信息以便快速定位问题/Please provide the following information to quickly locate the problem

**系统环境/System Environment：**

Windows 10 家庭中文版 22H2：
1060MaxQ + CUDA 11.6

**版本号/Version：**
Python：3.9, anaconda
Paddle：paddlepaddle-gpu==2.5.1.post116
PaddleOCR： 2.7
问题相关组件/Related components：PPStructure 版面回复

**运行指令/Command Code：**
python predict_system.py --image_dir=3.pdf --det_model_dir=inference/ch_PP-OCRv4_det_infer --rec_model_dir=inference/ch_PP-OCRv4_rec_infer --rec_char_dict_path=../ppocr/utils/ppocr_keys_v1.txt --table_model_dir=inference/ch_ppstructure_mobile_v2.0_SLANet_infer --table_char_dict_path=../ppocr/utils/dict/table_structure_dict_ch.txt --layout_model_dir=inference/picodet_lcnet_x1_0_fgd_layout_cdla_infer --layout_dict_path=../ppocr/utils/dict/layout_dict/layout_cdla_dict.txt --vis_font_path=../doc/fonts/simfang.ttf --recovery=True --output=./output/ --use_gpu=False

**完整报错/Complete Error Message：**
PDF文档中的表格如下：
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/c09c9e6f-40ed-48b0-af03-09f87f66c326)

使用版面恢复，运行到最后出现
ppocr ERROR: error in layout recovery image:1.pdf, err msg: list index out of range
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/85848adc-abfe-488d-b3a1-7a1f237ec024)

能输出文件
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/b80fe2ab-f87e-4497-9ef1-01b6717f5a86)
但是在 predict_system.py 292 行，调用 convert_info_docx(img, all_res, save_folder, img_name) 时出现问题

**问题定位：**
原因在于，识别的表格行列数出现了格式错误
从 predict_system.py 调用 convert_info_docx
跳转到 recovery_to_doc.py 63行 parser.handle_table(region['res']['html'], doc)
调用 recovery/table_process.py 第238行 def handle_table(self, html, doc)
识别到表格的 res：
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/838a52b7-c36e-4fc2-b695-548e8ada3cbd)
产生的 html 如下：
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/b7d1f2e6-d862-479f-be2a-b93ea048f3dc)

其中 handle_table 函数中，提取的 cols_len = 4
但是在表格的 html 中错误地出现了 colspan = 5
导致在函数中，出现了 list index out of range 的情况
![image](https://github.com/PaddlePaddle/PaddleOCR/assets/43161566/a29b29d3-0466-4e23-80bd-8c0b6d1e2587)


这个 colspan=5 是在表格分析的过程中产生的，我无法解决，需要求助

This same root cause must be fixed before merging.
REVIEW_EOF
