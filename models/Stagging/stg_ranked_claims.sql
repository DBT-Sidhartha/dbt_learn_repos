WITH ranked_claims AS
(
 SELECT claim_id,employee_id ,claim_date, expense_type, claimed_amount, currency, apporoval_status, approver_id,
 ROW_NUMBER() OVER (PARTITION BY claim_id ORDER BY claim_date DESC) AS rn
 FROM raw.public.expense_claim
)
SELECT claim_id,
employee_id ,
claim_date, 
UPPER(expense_type) AS expense_type, 
claimed_amount, 
currency, 
LOWER(apporoval_status) AS apporoval_status, 
approver_id
FROM ranked_claims
WHERE rn = 1