#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `rslib/src/import_export/text/csv/metadata.rs`:

This pull request introduces the defect later reported as "Issue with Importer Not Auto-Associating Tag Column". The
problem a user observed, and its root cause:

I found a new issue while importing. My import file has 16 columns, with the last column containing the tags. However, the importer does not automatically associate the last field with the tag column, requiring me to select it manually each time.

The legacy import version used to associate this correctly, so it seems like there has been a change in how this is handled.

```
#separator:Comma
#notetype:TEC - PR (TELEGRAM)/ADMON
#html:true
"2042265_3","<a href=""https://www.tecconcursos.com.br/questoes/2042265"">2042265</a><font size=""1""> | 2022 | FCC | DPE AM | Planejamento e Controle de Estoques</font>","Administração de Recursos Materiais","O dimensionamento de estoque tem como principal função determinar a metragem ideal do local de armazenamento dos materiais.  ","ERRADO","C","O dimensionamento de estoque visa determinar a quantidade ideal de materiais a serem mantidos, não a metragem física do local de armazenamento.","","","","","","","","","Questões::Banca::FCC Questões::Ano::2022 Questões::Dificuldade::Sem_Classif Questões::Matéria::Administração_de_Recursos_Materiais::Planejamento_e_Controle_de_Estoques Questões::Tamanho::1.CURTO Questões::Tipo::TRANSFORMADA Questões::Alternativa::Errada"

```
![image](https://github.com/user-attachments/assets/890df7e4-a227-4641-b494-e80e79b36d10)


![image](https://github.com/user-attachments/assets/078c41c2-3171-4ffa-9786-cd22ff7707f2)

This same root cause must be fixed before merging.
REVIEW_EOF
