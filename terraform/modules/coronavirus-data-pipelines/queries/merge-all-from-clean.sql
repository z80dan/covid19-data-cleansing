WITH address_register AS 
    (SELECT pcd,
         lad19cd,
         lad19nm
    FROM "${nspl_address_register_table}" ), web_with_address AS 
    (SELECT "${web_clean_table}".*,
         address_register.lad19cd AS web_lad_code,
         address_register.lad19nm AS web_lad_name
    FROM "${web_clean_table}"
    LEFT JOIN address_register
        ON regexp_replace("${web_clean_table}".postcode,'[^A-Z0-9]','') = regexp_replace(address_register.pcd,'[^A-Z0-9]','') ), ivr_with_address AS 
    (SELECT "${ivr_clean_table}".*,
         address_register.lad19cd AS ivr_lad_code,
         address_register.lad19nm AS ivr_lad_name
    FROM "${ivr_clean_table}"
    LEFT JOIN address_register
        ON regexp_replace("${ivr_clean_table}".ivr_postcode,'[^A-Z0-9]','') = regexp_replace(address_register.pcd,'[^A-Z0-9]','') ), nhs_with_address AS 
    (SELECT "${nhs_clean_table}".*,
         address_register.lad19cd AS nhs_lad_code,
         address_register.lad19nm AS nhs_lad_name
    FROM "${nhs_clean_table}"
    LEFT JOIN address_register
        ON regexp_replace("${nhs_clean_table}".nhs_postcode,'[^A-Z0-9]','') = regexp_replace(address_register.pcd,'[^A-Z0-9]','') ), all_together_now AS 
    (SELECT *
    FROM (nhs_with_address
    LEFT JOIN web_with_address
        ON nhs_with_address.nhs_nhs_number = web_with_address.nhs_number)
    LEFT JOIN ivr_with_address
        ON nhs_with_address.nhs_nhs_number = ivr_with_address.ivr_nhs_number )
SELECT *
FROM all_together_now
