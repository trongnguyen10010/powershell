$date = get-date -UFormat %d
$month = get-date -UFormat %m
$year = get-date -UFormat %Y
$folder_name = $month + $date +$year

$source = "R:\db.QBW"

$dest_dev = "Q:\"
$dest_prod = "P:\"

$dev_path = $dest_dev + $folder_name
$prod_path = $dest_prod + $folder_name

$yes = "Y"
Write-Host -ForegroundColor red "QuickBooks: pls make sure everyone is disconnected from $source"
$send = read-host -Prompt "Bro, are you sure you wanna run this script? (Y/N)"

if ($send -match $yes) {
##########################################################################################
# copy quickbooks db to onas

New-Item -Path $dest_dev -Name $folder_name -ItemType directory -ErrorAction stop -Verbose
Write-Host "created" $dev_path

Write-Host "copying" $source "to" $dev_path
Copy-Item -Path $source -Destination $dev_path -Verbose 

Write-Host $source "has been copied to" $dev_path -ForegroundColor Green

##########################################################################################
# copy quickbooks db to prnas

New-Item -Path $dest_prod -Name $folder_name -ItemType directory -ErrorAction stop -Verbose
Write-Host "created" $prod_path 

Write-Host "copying" $source "to" $prod_path
Copy-Item -Path $source -Destination $prod_path -Verbose

Write-Host $source "has been copied to" $prod_path -ForegroundColor Green

##########################################################################################
# send confirmation email

$from_email = "QuickBooks@comp.com"
$email_sub = "QB backup"
$smtp_server = "smtp.comp.com"
$to_email = $null

$date = get-date -Format D
$email_body = "
<html>
    <body>
        <p>
            Hi all,
            <br>
            There is a new QB backup file generated today $date.
            <br>
            Have a nice weekend!
            <br><br>
            <small>This email was sent by ITsupport@comp.com</small>
    </body>
</html>
"

$to_email = "DL@comp.com"
$cc_email = "email@comp.com"
$bcc_email = "email@comp.com"
 
send-mailmessage -to $to_email -Cc $cc_email -Bcc $bcc_email -from $from_email -subject $email_sub -body $email_body -BodyAsHtml -smtpServer $smtp_server 

Write-Host "Done"
}
else {
    Write-Host Abort!
}
