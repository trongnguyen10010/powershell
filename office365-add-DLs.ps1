$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session


####################################################################

$DLs = Get-Content -Path "C:\Users\tnguyen\New employee\hstone.txt"
$username = "hstone@taskstream.com"

####################################################################

foreach ($DL in $DLs) {
    Add-DistributionGroupMember -Member $username -Identity $DL
}
