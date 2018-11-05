[string[]]$SRVSLIST = @(
    "wscsvc",
    "xbgm",
    "vmms",
    "VSS",
    "ssh-agent"
)

[string[]]$RECOMMENDLIST = @(
    "update",
    "auto"
)

function main () {

    Get-Service -Verbose | Export-Csv .service.csv

    Write-Host "check"
    foreach ($srvice_name in $SRVSLIST) {
        Get-Service -Name $srvice_name | Where-Object { $_.StartType -eq "disable" }
    }

    Write-Host "recommend"
    foreach ($display_name in $RECOMMENDLIST) {
        Get-Service | Where-Object { $_.StartType -ne "disable" } | Where-Object { $_.DisplayName -like "*$display_name*" }
    }

}
main