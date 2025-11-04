# Copilot Instructions for Code Repository

## Project Overview

This is a utility script collection repository containing SQL Server administration and diagnostic tools. The codebase is organized by scripting language, with each directory containing scripts for specific SQL Server management tasks.

## Directory Structure

- **`Powershell/`** - PowerShell scripts for SQL Server automation and management
- **`TSQL/`** - T-SQL scripts for direct SQL Server query execution

## Script Architecture Pattern

Scripts in this repository follow a **dual-implementation pattern** where the same functionality may be implemented in both PowerShell and T-SQL to support different execution contexts:

- **PowerShell scripts** (e.g., `Powershell/getsqlversion.ps1`) are designed for **batch operations across multiple SQL Server instances**, using SMO (SQL Server Management Objects) for remote management
- **T-SQL scripts** (e.g., `TSQL/version.sql`) provide **single-instance query snippets** for direct execution in SSMS or other SQL clients

### Example: SQL Version Retrieval

- `Powershell/getsqlversion.ps1` - Reads server hostnames from `C:\Temp\sqlservers.txt` (one per line) and connects to each using SMO to retrieve version information
- `TSQL/version.sql` - Simple `SELECT @@version` query for single-instance execution

## PowerShell Conventions

### External Dependencies
- **SMO (SQL Server Management Objects)** - Loaded via reflection: `[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")`
- Scripts assume SMO is installed (typically via SQL Server Management Tools)

### Input File Pattern
PowerShell scripts that operate on multiple servers read server lists from text files:
- Default path: `C:\Temp\sqlservers.txt`
- Format: One hostname per line
- Include error handling for connection failures (see `getsqlversion.ps1` try-catch pattern)

### Output Format
Console output follows the pattern: `<servername> - <descriptive text>: <value>`
- Example: `sqlserver01 - Version: 15.0.4445.1`

## T-SQL Conventions

- Keep scripts minimal and focused on single queries
- Use comments to describe the script's purpose
- Scripts should be executable as-is in SSMS or Azure Data Studio

## When Adding New Scripts

1. **Determine execution context**: Batch operations → PowerShell; single queries → T-SQL
2. **For PowerShell scripts**:
   - Load SMO if connecting to SQL Server
   - Accept server lists from file input
   - Include try-catch for connection handling
   - Output results to console with descriptive formatting
3. **For T-SQL scripts**:
   - Keep queries simple and self-contained
   - Add comments explaining the query's purpose
   - Avoid external dependencies

## Repository Purpose

This is a personal/team utilities collection, not a production application. Scripts are standalone tools for SQL Server DBA tasks and diagnostics. There is no build process, dependency management, or automated testing—each script is executed directly.
