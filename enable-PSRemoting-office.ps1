$list = Get-Content "C:\Users\PStools\winrm-error-office-----.txt"


$command_prefix = "psexec.exe \\"
$command_suffix = " -s powershell Enable-PSRemoting -Force"
foreach ($pc in $list){
    $command = $command_prefix + $pc + $command_suffix
    Write-Host "enabling PSRemoting on" $pc -ForegroundColor Green
    $command
    Invoke-Expression -Command $command
    Invoke-Expression return 
    
}
