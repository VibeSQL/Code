-- ISO Format:  '2026-01-22' or '2026-01-22 14:30:00' (YYYY-MM-DD)
SELECT * FROM YourTable
ORDER BY CAST(YourColumn AS DATE)

-- US Format: '01/22/2026' (MM/DD/YYYY) - Style 101
SELECT * FROM YourTable
ORDER BY CONVERT(DATE, YourColumn, 101)

-- UK/European Format: '22/01/2026' (DD/MM/YYYY) - Style 103
SELECT * FROM YourTable
ORDER BY CONVERT(DATE, YourColumn, 103)

-- Format:  '22 Jan 2026' (DD Mon YYYY) - Style 106
SELECT * FROM YourTable
ORDER BY CONVERT(DATE, YourColumn, 106)

-- Format: 'Jan 22, 2026' (Mon DD, YYYY) - Style 107
SELECT * FROM YourTable
ORDER BY CONVERT(DATE, YourColumn, 107)

-- Format: '20260122' (YYYYMMDD) - Style 112
SELECT * FROM YourTable
ORDER BY CONVERT(DATE, YourColumn, 112)
