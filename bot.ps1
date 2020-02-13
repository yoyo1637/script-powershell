import-module "C:\Scripts\lib_script.ps1" -force

# sur le bot : 
function global:FRX_Socket-MessageAction{
    param($message)
    $stop = $false
    switch ($message) {
        {$_ -match "HACKMETHIS"  } {write-host "hack this" -ForegroundColor green}
  