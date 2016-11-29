# Step 1 - install nxlog msi file using pdq deploy

$source = "C:\Users\tnguyen\Desktop\prod_nxlog\"
$prod_machines = $source+"test-list.txt"

$prefix="\\"
$cert_file = $source+"device.crt"
$log_config = $source+"nxlog.conf"
$log_config_location = "C$\Program Files (x86)\nxlog\conf\"
$cert_file_location = "C$\Program Files (x86)\nxlog\cert\"
$installation_path = "\C$\Program Files (x86)\nxlog"

foreach ($pc in (Get-Content -path $prod_machines)) {
    $log_config_path = $prefix+$pc+"`\"+$log_config_location
    $cert_file_path = $prefix+$pc+"`\"+$cert_file_location
    if (Test-Path -Path ($prefix+$pc+$installation_path)) {
        write-host -ForegroundColor green $pc
       
        try {
            write-host "Copying" $log_config_path
            Copy-Item -Path $log_config -Destination $log_config_path -ErrorAction Stop
        }
        catch {
            Write-Host -ForegroundColor red $pc ": cannot copy nxlog.conf"
        }


	try {    
            write-host "Copying" $cert_file_path		
            Copy-Item -Path $cert_file -Destination $cert_file_path -ErrorAction Stop
        }
        catch {
            Write-Host -ForegroundColor red $pc ": cannot copy device.crt" 
        }
    
    
    
        #restart nxlog service
	try {
		$service = get-service -ComputerName $pc -Name nxlog -ErrorAction Stop
		}
		catch {
			write-host -ForegroundColor red "error"
		}
		try {      
			write-host "Stopping service"
			$service.stop()
        }
        catch {
            Write-Host -ForegroundColor red $pc ": cannot stop nxlog service" 
        }
		try { 
			write-host "Starting service"
			$service.start()
        }
        catch {
            Write-Host -ForegroundColor red $pc ": cannot start nxlog service" 
        }
		write-host
    }
        
    else {
        Write-Host -ForegroundColor Red $pc ": please install nxlog using pdq deploy"
    }
}
 
