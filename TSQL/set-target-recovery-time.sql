/* Set TARGET_RECOVERY_TIME to 60 seconds for all user databases */

-- This script sets the TARGET_RECOVERY_TIME to 60 seconds for all user databases
-- on the current SQL Server instance. System databases are excluded.

DECLARE @DatabaseName NVARCHAR(128)
DECLARE @SQL NVARCHAR(MAX)

DECLARE db_cursor CURSOR FOR
    SELECT name
    FROM sys.databases
    WHERE database_id > 4  -- Exclude system databases (master, tempdb, model, msdb)
        AND state_desc = 'ONLINE'
        AND is_read_only = 0

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @DatabaseName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET TARGET_RECOVERY_TIME = 60 SECONDS;'
    
    PRINT 'Setting TARGET_RECOVERY_TIME = 60 for database: ' + @DatabaseName
    
    BEGIN TRY
        EXEC sp_executesql @SQL
        PRINT '  - Success'
    END TRY
    BEGIN CATCH
        PRINT '  - Error: ' + ERROR_MESSAGE()
    END CATCH
    
    FETCH NEXT FROM db_cursor INTO @DatabaseName
END

CLOSE db_cursor
DEALLOCATE db_cursor

-- Verify the changes
SELECT 
    name AS DatabaseName,
    target_recovery_time_in_seconds AS TargetRecoveryTime
FROM sys.databases
WHERE database_id > 4
ORDER BY name
