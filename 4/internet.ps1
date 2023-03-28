ping -c 5 google.com


if($LASTEXITCODE -eq 0) {
    # valid
    Write-Output "yes"
}
else {
    # invalid
    Write-Output "no"
}