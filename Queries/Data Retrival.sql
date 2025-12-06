## Queries /Data_Retrieval

-- 1. GET ALL MEDICINES
SELECT * FROM medicine;

-- 2. GET ACTIVE BATCHES WITH MEDICINE INFO
SELECT m.medicine_name, b.batch_number, b.quantity, b.expiry_date
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.status = 'ACTIVE';

-- 3. GET EXPIRING MEDICINES (NEXT 30 DAYS)
SELECT m.medicine_name, b.batch_number, 
       b.expiry_date, 
       ROUND(b.expiry_date - SYSDATE) as days_left
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.expiry_date BETWEEN SYSDATE AND SYSDATE + 30
ORDER BY b.expiry_date;

-- 4. GET TOTAL INVENTORY VALUE
SELECT m.category, 
       SUM(b.quantity) as total_quantity,
       SUM(b.quantity * b.unit_cost) as total_value
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.status = 'ACTIVE'
GROUP BY m.category;

-- 5. GET EXPIRED MEDICINES
SELECT m.medicine_name, b.batch_number, b.quantity
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.expiry_date < SYSDATE
  AND b.status != 'EXPIRED';

-- 6. GET MEDICINE DETAILS WITH URGENCY STATUS
SELECT m.medicine_name, b.batch_number,
       CASE 
           WHEN b.expiry_date < SYSDATE THEN 'EXPIRED'
           WHEN b.expiry_date < SYSDATE + 7 THEN 'CRITICAL'
           WHEN b.expiry_date < SYSDATE + 30 THEN 'URGENT'
           ELSE 'SAFE'
       END as status
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id;

-- 7. GET TOP 10 MEDICINES BY QUANTITY
SELECT medicine_name, SUM(quantity) as total_stock
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.status = 'ACTIVE'
GROUP BY medicine_name
ORDER BY total_stock DESC
FETCH FIRST 10 ROWS ONLY;
