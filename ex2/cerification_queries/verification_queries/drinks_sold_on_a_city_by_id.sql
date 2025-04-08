USE pizza_store;
SELECT count(*) FROM producttype
JOIN product ON producttype.productTypeId =  product.productTypeId
JOIN orderdetails ON product.productId = orderdetails.productId
JOIN pizza_store.`order` ON orderdetails.orderId = pizza_store.`order`.orderId
JOIN `client` ON `order`.clientId = `client`.clientId
JOIN city ON `client`.cityId = city.cityId
WHERE producttype.name = "Drinks"
AND city.cityId = 2;
