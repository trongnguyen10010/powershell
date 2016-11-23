<#
        remove kbs from list of machines
		powershell - Invoke-Command -ComputerName HOSTNAME -ScriptBlock {cmd.exe /c "%SYSTEMROOT%\System32\wusa.exe /uninstall /norestart /kb:3112148 /quiet"}
		cmd - wusa.exe /uninstall /norestart /kb:3112148 /quiet
#>

$list_of_machines = #"C:\Users\user\Desktop\DR-remove-timezone-KBs\"
$log_file = "C:\Users\user\Desktop\DR-remove-timezone-KBs\log.txt"
$timezone_KBs = 3112148, 3077715, 3148851, 3153731, 3162835, 2981580, 3013410
$timestamp = get-date

"`nScript started at: " + $timestamp + "`nCannot connect to the following servers:`n"| out-file -append $log_file

foreach ($machine in (Get-Content -Path $list_of_machines)){
    foreach ($kb in $timezone_KBs) {
        try {
            write-host $machine ": removing kb$kb"
			$command = "%SYSTEMROOT%\System32\wusa.exe /uninstall /norestart /kb:$kb /quiet"
            Invoke-Command -ComputerName $machine -ScriptBlock {param($p1) cmd.exe /c $p1} -ErrorAction stop -ArgumentList $command		
        }
        catch {
            $output = $machine + ": cannot uninstall KB(s)"
			Write-Host -ForegroundColor red $output
			$machine | out-file -append $log_file
			
        }        
    }
}
