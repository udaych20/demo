🧹 Step 1: Delete Existing HyperWorks / ALTAIR Sample Data
This script cleans only the previously inserted HyperWorks sample data from the last 180 days:

sql
Copy
Edit
DELETE FROM license_utilization2
WHERE vendor = 'ALTAIR'
  AND feature = 'HyperWorks'
  AND usage_time BETWEEN CURRENT_DATE - INTERVAL '180 days' AND CURRENT_DATE;
🔄 Step 2: Insert HyperWorks / ALTAIR Data Every 3 Days (180-day span)
This gives you:

1 row every 3 days

60 rows total over 180 days

Time-stamped at 12 PM

Usage, borrowed, denials aligned properly

sql
Copy
Edit
DO $$
DECLARE 
  i INTEGER := 0;
  usage_time TIMESTAMP;
  max_id INTEGER := (SELECT COALESCE(MAX(id), 0) FROM license_utilization2);
  total_licenses INTEGER := 10;
  used_val INTEGER;
  borrowed_val INTEGER;
  denial_val INTEGER;
BEGIN
  WHILE i <= 180 LOOP
    usage_time := date_trunc('day', CURRENT_DATE) - INTERVAL '1 day' * i + INTERVAL '12 hours';

    used_val := FLOOR(5 + RANDOM() * 5); -- 5 to 9 used
    borrowed_val := FLOOR(RANDOM() * (used_val + 1));
    denial_val := CASE 
                    WHEN used_val = total_licenses THEN FLOOR(1 + RANDOM() * 3)
                    ELSE 0
                  END;

    INSERT INTO license_utilization2 (
      id, borrowed, denials, expiring, expiry_date,
      feature, server, total, usage_time, used, vendor, borrowed_till
    )
    VALUES (
      max_id + i + 1,
      borrowed_val,
      denial_val,
      CASE WHEN i % 30 = 0 THEN 1 ELSE 0 END,
      CURRENT_DATE + INTERVAL '30 days',
      'HyperWorks',
      'as-alt-server',
      total_licenses,
      usage_time,
      used_val,
      'ALTAIR',
      NULL
    );

    i := i + 3; -- every 3rd day
  END LOOP;
END $$;
Let me know if you'd like this bundled as a .sql file again or need this applied to another vendor/feature (e.g., ANSYS, HSPICE, etc.) with the same 3-day interval.






