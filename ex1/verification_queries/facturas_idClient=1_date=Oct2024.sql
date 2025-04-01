USE `cul_d_ampolla`;
SELECT COUNT(*) AS total_invoices
FROM cul_d_ampolla.sale
WHERE idClient = 1
AND date >= '2024-10-01'
AND date <= '2024-10-31';
