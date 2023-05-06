SELECT DISTINCT orderid, totalprice, campaignid
FROM orders 
WHERE campaignid IS NOT NULL
ORDER BY totalprice DESC;

SELECT A.productid, B.totalprice, B.orderid, sum(B.numunits) as units
FROM products A JOIN
    order_lines B
    ON
       A.productid = B.productid
WHERE b.totalprice > 1
group by a.productid, b.totalprice, b.orderid
HAVING sum(B.numunits) > 1
ORDER BY units DESC;

SELECT A.productid, B.totalprice, B.orderid, sum(B.numunits) as units
FROM products A JOIN
    order_lines B
    ON
       A.productid = B.productid
WHERE b.totalprice > 1
group by rollup (b.orderid, a.productid, b.totalprice);

SELECT a.orderid, c.productgroupname, a.campaignid, sum(a.totalprice) AS order_total
FROM orders A, order_lines B, products C 
WHERE a.orderid = b.orderid AND b.productid = c.productid 
    AND a.orderid IS NOT NULL
GROUP BY ROLLUP(a.orderid, c.productgroupname, a.campaignid)
HAVING sum(a.totalprice)>100;

SELECT a.productid, a.instockflag, a.fullprice, b.numunits, b.totalprice, c.orderdate
FROM products A, order_lines B, orders C
WHERE a.productid = b.productid AND b.orderid = b.orderid
    AND b.numunits > 1
GROUP BY c.orderdate, a.productid, a.instockflag, a.fullprice, b.numunits, b.totalprice;