$cmd = 'setup.exe /S /v "/qn REBOOT=R ADDLOCAL=ALL REMOVE=Hgfs"'

$source_folder = "\\network\VMware-tools-folder"
$list_of_vms = "\\path\to\text.txt"
$when_the_error_code_is_1_logfile = "\\file.log" # mailto:ttn9.jobs@gmail.com

foreach ($computer in (Get-Content -Path $list_of_vms)){
    $dest_folder = "\\$computer\Vmware-Tools-installation"
    
    if (!(Test-Path -Path $dest_folder)) {
        Write-Host "Copying files to $dest_folder"
        Copy-Item -Path $source_folder -Destination $dest_folder -Recurse 
        Invoke-Command -ComputerName $computer -ScriptBlock {cmd /c 'C:\Vmware-Tools-installation\install.txt.cmd'} 
        # install.txt.cmd <= setup.exe /S /v "/qn REBOOT=R ADDLOCAL=ALL REMOVE=Hgfs"
        Write-Host -ForegroundColor green $computer
        Remove-Item -Path $dest_folder -Recurse
            }
    else {
        Write-Host -ForegroundColor red $computer
        $computer | Out-File -append -filepath $when_the_error_code_is_1_logfile
    }
}
