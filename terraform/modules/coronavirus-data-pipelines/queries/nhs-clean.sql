CREATE TABLE "${nhs_clean_table}" AS
SELECT

regexp_replace(upper(trim(CAST(nhsnumber AS VARCHAR) )),'[^A-Z0-9]','') AS nhs_nhs_number,

CONCAT(SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 5, 4), 
       '-', 
       SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 3, 2), 
       '-', 
       SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 1, 2)) AS nhs_dob,

SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 5, 4) AS nhs_dob_year,

SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 3, 2) AS nhs_dob_month,

SUBSTRING(LPAD(CAST(dateofbirth AS VARCHAR), 8, '0'), 1, 2) AS nhs_dob_day,

REGEXP_REPLACE(TRIM(UPPER(patienttitle)), '[^A-Za-z]', '') AS nhs_patient_title,

REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TRIM(patientfirstName)), '(\\s+)',' '), 
               '[^A-Z0-9\\\\ \,\.\-]','') AS nhs_patients_first_name,

REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TRIM(patientotherName)), '(\\s+)',' '), 
               '[^A-Z0-9\\\\ \,\.\-]','') AS nhs_patients_other_name,

REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TRIM(patientsurname)), '(\\s+)',' '), 
               '[^A-Z0-9\\\\ \,\.\-]','') AS nhs_patients_surname,

regexp_replace(regexp_replace(upper(trim(patientaddress_line1)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_patients_address_line1,

regexp_replace(regexp_replace(upper(trim(patientaddress_line2)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_patients_address_line2,

regexp_replace(regexp_replace(upper(trim(patientaddress_line3)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_patients_address_line3,

regexp_replace(regexp_replace(upper(trim(patientaddress_line4)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_patients_address_line4,

regexp_replace(regexp_replace(upper(trim(patientaddress_line5)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_patients_address_line5,

regexp_replace(upper(patientaddress_postcode),'[^A-Z0-9]','') as nhs_postcode,

regexp_replace(regexp_replace(upper(trim(practice_code)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_practice_code,

regexp_replace(regexp_replace(upper(trim(practice_name)), '(\\s+)', ' '), 
               '[^A-Z0-9\\\\ \,\.\-]', '') AS nhs_practice_name,

contact_telephone As nhs_contact_telephone

FROM "${nhs_table}"
