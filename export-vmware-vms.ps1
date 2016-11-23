#vmware inventory list
Add-PSSnapin vmware.vimautomation.core


$rt = Get-Credential
$list = "C:\Users\user\Vmware\dev-vmhosts.txt"
$vmhosts = Get-Content -Path $list

foreach ($vmhost in $vmhosts) {

    Connect-VIServer -Server $vmhost -Credential $rt -Verbose
    $vms = Get-VM -Server $vmhost
    foreach ($vm in $vms) {
        $state = Get-VM -Name $vm | select -Property "PowerState"
        $HostName = Get-VMGuest -Server $vmhost -vm $vm | select -Property "HostName"
        $IP = Get-VMGuest -Server $vmhost -vm $vm | select -Property "IPAddress"
        $OSFullName = Get-VMGuest -Server $vmhost -vm $vm | select -Property "OSFullName"
        $ToolsVersion = Get-VMGuest -Server $vmhost -vm $vm | select -Property "HostName"
        $out = $vm + $HostName + $IP + $OSFullName + $state + $ToolsVersion + $vmhost
        $out | Format-Table -AutoSize


    }

    <#
    $ip = Get-VMGuest -Server "x.x.x.x" -vm "Integration-W" | select -Property "IPAddress"
    $os = Get-VMGuest -Server "x.x.x.x" -vm "Integration-W" | select -Property "OSFullName"
    $name = Get-VMGuest -Server "x.x.x.x" -vm "Integration-W" | select -Property "HostName"
    write-host $ip + $os $name


    $out = Get-VMGuest -Server "x.x.x.x" -vm * | select -Property "VmName","HostName" ,"IPAddress" , "OSFullName" , "ToolsVersion"
    $out | Format-Table -AutoSize

    get-vm -Server  "x.x.x.x"
    #>

}
