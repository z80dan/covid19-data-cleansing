SELECT * FROM
(
  SELECT * FROM
  "${ivr_clean_table}" AS a FULL OUTER JOIN "${web_clean_table}" AS b
  ON a.ivr_nhs_number = b.nhs_number
) AS ivr_and_web INNER JOIN "${nhs_clean_table}" ON ivr_and_web.ivr_nhs_number = "${nhs_clean_table}".nhs_nhs_number;

