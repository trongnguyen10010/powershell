$UserCredential = Get-Credential
$DLs = Get-Content -Path "N:\path\file.txt"
$username = "ttn9.jobs@gmail.com"

$Session = New-PSSession 
-ConfigurationName Microsoft.Exchange
-ConnectionUri https://outlook.office365.com/powershell-liveid/
-Credential $UserCredential 
-Authentication Basic 
-AllowRedirection
Import-PSSession $Session

foreach ($DL in $DLs) {
    Add-DistributionGroupMember -Member $username -Identity $DL
}
