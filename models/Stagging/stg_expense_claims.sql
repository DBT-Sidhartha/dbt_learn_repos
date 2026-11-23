Select 
    claim_id,
    employee_id,
    claim_date,
    UPPER(expense_type) AS expense_type,
    claimed_amount,
    currency,
    LOWER(apporoval_status) AS apporoval_status,
    approver_id
FROM RAW.PUBLIC.expense_claim