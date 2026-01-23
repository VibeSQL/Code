SELECT
    YourColumn,
    TRY_CONVERT(DATE, YourColumn) AS DateValue
FROM YourTable
ORDER BY TRY_CONVERT(DATE, YourColumn)

-- With style code for specific format
SELECT
    YourColumn,
    TRY_CONVERT(DATE, YourColumn, 103) AS DateValue
FROM YourTable
ORDER BY TRY_CONVERT(DATE, YourColumn, 103)
