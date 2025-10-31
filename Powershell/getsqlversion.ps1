# Get SQL Server version
# Reads hostnames from a file. Keep one hostname per row. 
#
# Output:
#
#   sqlserver01 - Version: 15.0.4445.1
#   sqlserver02 - Version: 15.0.4445.1
#   sqlserver03 - Version: 15.0.4445.1



# Path to your text file
$serverListPath = "C:\Temp\sqlservers.txt"

# Load SMO (SQL Server Management Objects)
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null

# Read hostnames from file
$servers = Get-Content $serverListPath

foreach ($serverName in $servers) {
    try {
        $server = New-Object Microsoft.SqlServer.Management.Smo.Server $serverName
        Write-Output "$serverName - Version: $($server.Information.VersionString)"
    } catch {
        Write-Output "$serverName - Could not connect or retrieve version."
    }
}