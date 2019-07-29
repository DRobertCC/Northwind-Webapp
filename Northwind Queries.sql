Task 1
-- Lists Products and their Suppliers. Display the ProductName and the CompanyName of the Supplier. Name result columns as Product and Company respectively. Order the results alphabetically by ProductName and by CompanyName.

SELECT P.product_name AS "Product", S.company_name AS "Company"
FROM products AS P
	INNER JOIN suppliers AS S
		ON P.supplier_id = S.supplier_id
	ORDER BY "Product", "Company";
-- 	77 rows
======================================================================
Task 2
-- List Suppliers and the number of products they supply. Display the CompanyName of the Supplier and the number of products the supplier has. Name result columns as Company and NumberOfProducts respectively. Order the results so that the Supplier with the most products is displayed first. Order Suppliers with identical number of products alphabetically.

SELECT S.company_name AS "Company", count(P.product_id) AS "NumberOfProducts"
FROM products AS P
	INNER JOIN suppliers AS S
		ON P.supplier_id = S.supplier_id
	GROUP BY "Company"
	ORDER BY "NumberOfProducts" DESC, "Company";
-- 	29 Rows
======================================================================
Task 3
-- List Suppliers and the number of products they supply (similarly to Task 2), but only those who supply 5 different products. Display the CompanyName of the Suppliers. Order the results alphabetically.

SELECT S.company_name AS "Company"--, count(P.product_id) AS "NumberOfProducts"
FROM products AS P
	INNER JOIN suppliers AS S
		ON P.supplier_id = S.supplier_id
	GROUP BY "Company"
	HAVING COUNT(P.product_id) = 5
	ORDER BY "Company";
-- 	3 Rows
======================================================================
Task 4
-- List all Customers and their orders (if any). Display the CompanyName of Customers and all of their orders as a comma separated list (e.g "CompanyA | 1234, 2345, 4567"). Order the results alphabetically by CompanyName.
-- 	NULLs: Fissa ..., Paris ...

SELECT C.company_name AS "Company Name", ARRAY_AGG(O.order_id) AS "Order IDs"
-- SELECT C.company_name AS "Company Name",  String_AGG (cast(Order_id as text), ',')
FROM customers AS C
	LEFT JOIN orders AS O
		ON C.customer_id = O.customer_id
	GROUP BY "Company Name"
	ORDER BY "Company Name";
-- 	91 Rows


-- Work in Progress version:
		SELECT C.company_name AS "Company Name", O.order_id AS "Order ID"
		FROM customers AS C
			LEFT JOIN orders AS O
				ON C.customer_id = O.customer_id
			ORDER BY "Company Name";
-- 			832 Rows
======================================================================
Task 5
-- List Suppliers and their single most expensive Product. Display the CompanyName of the Supplier and the ProductName and UnitPrice of the Product. Name result columns as Company, Product and Price respectively. Order the results so the most expensive Product is on top. Order the results of the same price by ProductName, then by CompanyName alphabetically.

SELECT S.company_name AS "Company", P.product_name AS "Product", P.unit_price AS "Price"
FROM products AS P
	INNER JOIN suppliers AS S
		ON P.supplier_id = S.supplier_id
		INNER JOIN (
			SELECT P.supplier_id, MAX(P.unit_price) AS "Max Unit Price"
			  FROM  products AS P
			  GROUP BY P.supplier_id
			  ) AS temp
				ON P.supplier_id = temp.supplier_id AND P.unit_price = temp."Max Unit Price"
			  ORDER BY "Price" DESC, "Product", "Company";
-- 	29 Rows

-- OR:

SELECT S.company_name AS "Company", P.product_name AS "Product", P.unit_price AS "Price"
FROM products AS P
	INNER JOIN suppliers AS S
		ON P.supplier_id = S.supplier_id
		LEFT JOIN products AS PP
			ON P.supplier_id = PP.supplier_id AND P.unit_price < PP.unit_price
		WHERE PP.supplier_id IS NULL -- or product_id
		ORDER BY "Price" DESC, "Product", "Company";
		--ORDER BY P.unit_price DESC, P.product_name ASC, S.company_name ASC;
-- 	29 Rows


-- Work in Progress version:
		SELECT S.company_name AS "Company", P.product_name AS "Product", P.unit_price AS "Price"
		FROM products AS P
			INNER JOIN suppliers AS S
				ON P.supplier_id = S.supplier_id
			ORDER BY "Company", "Price" DESC;
	-- 	77 Rows

	--Segéd Query:
		SELECT P.supplier_id, MAX(P.unit_price)
		FROM products AS P
		GROUP BY P.supplier_id;
	--	29 Rows
	
https://dev.mysql.com/doc/refman/5.7/en/example-maximum-column-group-row.html :
