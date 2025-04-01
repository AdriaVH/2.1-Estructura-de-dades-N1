USE cul_d_ampolla;
SELECT * FROM glasses
JOIN saledetails on glasses.id = saledetails.glassesId
JOIN sale ON saledetails.saleId = sale.id
WHERE sale.idEmployee = 5
AND YEAR(sale.date) = 2024;