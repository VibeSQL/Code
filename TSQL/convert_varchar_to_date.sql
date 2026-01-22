-- Using CAST (simpler, works with ISO formats)
SELECT
    YourColumn,
    CAST(YourColumn AS DATE) AS DateValue
FROM YourTable
ORDER BY CAST(YourColumn AS DATE)


-- Using CONVERT (more flexible, supports various date formats)
SELECT
    YourColumn,
    CONVERT(DATE, YourColumn) AS DateValue
FROM YourTable
ORDER BY CONVERT(DATE, YourColumn)
