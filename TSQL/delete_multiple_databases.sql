-- Script to delete multiple databases
-- First sets them to single user mode with rollback immediate, then deletes them

DECLARE @DatabaseName NVARCHAR(128)
DECLARE @SQL NVARCHAR(MAX)

-- Cursor to iterate through databases matching the pattern
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE name LIKE 'database_name_change_me'
  AND name NOT IN ('master', 'tempdb', 'model', 'msdb') -- Exclude system databases

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @DatabaseName

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        PRINT 'Processing database: ' + @DatabaseName
        
        -- Set database to single user mode with rollback immediate
        SET @SQL = 'ALTER DATABASE [' + @DatabaseName + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;'
        PRINT 'Executing: ' + @SQL
        EXEC sp_executesql @SQL
        
        -- Drop the database
        SET @SQL = 'DROP DATABASE [' + @DatabaseName + '];'
        PRINT 'Executing: ' + @SQL
        EXEC sp_executesql @SQL
        
        PRINT 'Successfully deleted database: ' + @DatabaseName
        PRINT '---'
    END TRY
    BEGIN CATCH
        PRINT 'Error processing database: ' + @DatabaseName
        PRINT 'Error Message: ' + ERROR_MESSAGE()
        PRINT '---'
        
        -- Attempt to set database back to multi-user if deletion failed
        BEGIN TRY
            SET @SQL = 'ALTER DATABASE [' + @DatabaseName + '] SET MULTI_USER;'
            EXEC sp_executesql @SQL
        END TRY
        BEGIN CATCH
            -- Ignore errors when trying to restore multi-user mode
        END CATCH
    END CATCH
    
    FETCH NEXT FROM db_cursor INTO @DatabaseName
END

CLOSE db_cursor
DEALLOCATE db_cursor

PRINT 'Database deletion process completed.'
