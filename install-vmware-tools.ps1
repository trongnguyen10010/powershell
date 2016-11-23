#
# this script will install vmware tools on windows machines
#

$cmd = '/S /v "/qn REBOOT=R ADDLOCAL=ALL REMOVE=Hgfs"'
$source_folder = "\\nas\C$\Users\Vmware-Tools"

$list_of_pcs = "C:\Users\Vmware-Tools\servers.txt"

foreach ($computer in (Get-Content -Path $list_of_pcs)){
    $dest_folder = "\\$computer\c$\Vmware-Tools"
    Write-Host -ForegroundColor green $computer
    if (!(Test-Path -Path $dest_folder)) {
        Write-Host "Copying files to $dest_folder"
        Copy-Item -Path $source_folder -Destination $dest_folder -Recurse #-Verbose 
    }
    
    Write-Host -ForegroundColor Green "Installing vmware tools"
    Invoke-Command -ComputerName $computer -ScriptBlock {cmd /c 'C:\Vmware-Tools\install-vmtools.txt.cmd'} 

    Write-Host "Cleaning up $dest_folder"
    Remove-Item -Path $dest_folder -Recurse #-Verbose
}
