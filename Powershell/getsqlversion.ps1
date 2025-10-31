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