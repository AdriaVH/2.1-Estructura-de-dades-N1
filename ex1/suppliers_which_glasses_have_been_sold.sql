USE cul_d_ampolla;
SELECT DISTINCT supplier.id FROM supplier
JOIN glassesbrand ON supplier.id = glassesbrand.supplierId
JOIN glasses ON glassesbrand.name = glasses.brand
WHERE glasses.clientId IS NOT NULL;
