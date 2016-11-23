# create vmware inventory


#get-vm -Server $vmhost

#get-vm | Select-Object -Property Name

#get-vm | Get-VMGuest | Select-Object -Property IPAddress

#get-vm | Get-VMGuest | Select-Object -Property OSFullName

get-vm | Get-VMGuest | select VmName,HostName,IPAddress,OSFullName,State,Nics | sort HostName | Format-Table -AutoSize


get-vm -Server * | Get-VMGuest | select VmName,HostName,IPAddress,OSFullName,State,Nics | sort HostName | Format-Table -AutoSize 
