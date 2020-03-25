SELECT i.*,
         j.lad19cd AS ivr_ua_code,
         j.lad19nm AS ivr_ua_name
FROM
    (SELECT g.*,
         h.lad19cd AS web_ua_code,
         h.lad19nm AS web_ua_name
    FROM 
        (SELECT e.*,
         f.lad19cd AS spine_lad_code,
         f.lad19nm AS spine_lad_name
        FROM 
            (SELECT c.*,
         d.*
            FROM 
                (SELECT a.*,
         b.*
                FROM 
                    (SELECT *
                    FROM "${nhs_clean_table}") AS a
                    LEFT JOIN "${web_clean_table}" AS b
                        ON trim(a.nhs_nhs_number)=trim(b.nhs_number)) AS c
                    LEFT JOIN "${ivr_clean_table}" AS d
                        ON trim(c.nhs_nhs_number)=trim(d.ivr_nhs_number)) AS e
                    LEFT JOIN "${nspl_address_register_table}" AS f
                        ON trim(e.nhs_postcode) = regexp_replace(f.pcd,'(\\s+)','')
                    WHERE e.nhs_postcode <>'') AS g
                    LEFT JOIN "${nspl_address_register_table}" AS h
                        ON trim(g.postcode) = regexp_replace(h.pcd,'(\\s+)','')
                    WHERE g.postcode <>'') AS i
                LEFT JOIN "${nspl_address_register_table}" AS j
                ON trim(i.ivr_postcode) = regexp_replace(j.pcd,'(\\s+)','')
        WHERE i.ivr_postcode <>'';
