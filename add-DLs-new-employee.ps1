$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session


####################################################################

$DLs = Get-Content -Path "C:\Users\user\New employee\TEXT.txt"
$username = "user@comp.com"

####################################################################

foreach ($DL in $DLs) {
    
    Add-DistributionGroupMember -Member $username -Identity $DL
    
}
