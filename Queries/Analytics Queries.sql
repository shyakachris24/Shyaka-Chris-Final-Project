-- 1. RANK MEDICINES BY EXPIRY (Window Function)
SELECT 
    ROW_NUMBER() OVER (ORDER BY expiry_date) as rank,
    medicine_name, 
    batch_number,
    expiry_date,
    ROUND(expiry_date - SYSDATE) as days_left
FROM batch b
JOIN medicine m ON b.medicine_id = m.medicine_id
WHERE b.status = 'ACTIVE';

-- 2. RUNNING TOTAL OF INVENTORY VALUE
SELECT 
    medicine_name,
    quantity * unit_cost as batch_value,
    SUM(quantity * unit_cost) OVER (
        ORDER BY medicine_name
    ) as running_total
FROM batch b
JOIN medicine m ON b.medicine_id = m.medicine_id
WHERE b.status = 'ACTIVE';

-- 3. MONTHLY EXPIRY REPORT
SELECT 
    TO_CHAR(expiry_date, 'MON-YYYY') as expiry_month,
    COUNT(*) as batches_expiring,
    SUM(quantity) as total_quantity
FROM batch
WHERE status = 'ACTIVE'
GROUP BY TO_CHAR(expiry_date, 'MON-YYYY')
ORDER BY expiry_month;

-- 4. CATEGORY PERFORMANCE
SELECT 
    category,
    COUNT(*) as medicine_count,
    AVG(unit_cost) as avg_price,
    SUM(quantity) as total_stock
FROM medicine m
JOIN batch b ON m.medicine_id = b.medicine_id
WHERE b.status = 'ACTIVE'
GROUP BY category;

-- 5. EXPIRY RISK ANALYSIS
SELECT 
    CASE 
        WHEN days_left < 0 THEN 'EXPIRED'
        WHEN days_left < 7 THEN 'CRITICAL'
        WHEN days_left < 30 THEN 'HIGH RISK'
        WHEN days_left < 90 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END as risk_level,
    COUNT(*) as batch_count,
    SUM(quantity) as total_quantity
FROM (
    SELECT ROUND(expiry_date - SYSDATE) as days_left, quantity
    FROM batch
    WHERE status = 'ACTIVE'
)
GROUP BY CASE 
    WHEN days_left < 0 THEN 'EXPIRED'
    WHEN days_left < 7 THEN 'CRITICAL'
    WHEN days_left < 30 THEN 'HIGH RISK'
    WHEN days_left < 90 THEN 'MEDIUM RISK'
    ELSE 'LOW RISK'
END;
