 
 

function total_size ($path) {
    $total = (Get-ChildItem -LiteralPath $path -Recurse | Measure-Object -Property Length -sum).sum /1gb
    return $total 
}

function find_relative_path ($the_date) {

    $get_date = (get-date).AddDays($the_date)
    $year = $get_date.Year
    $month = $get_date.Month
    $date = $get_date.Day

    $relative_path = "\"+ $year +"\"+ $month +"\"+ $date
    return $relative_path
}

function check_backup ($source, $destination, $threshold, $folder) {
    if (Test-Path $source) {
        if (Test-Path $destination) {
            $src = total_size $source
            $dest = total_size $destination
            $error_code = 0 

            $diff = $src - $dest
            Write-Host $diff
            if ($diff -le $threshold) {
                $error_code = 0 # moving on
            }
            else {
                $error_code = 1 # shit is about to get real
                send-mailmessage -to "user<cc@cc.com>" -from "DRfile1 monitor <monitor@cc.com>" -subject $folder -body "Please investigate" -smtpServer qa-smtp1.ts.com
            }
            return $error_code
        }
        else {
           send-mailmessage -to "user<cc@cc.com>" -from "DRfile1 monitor <monitor@cc.com>" -subject ($destination + " does not exist") -body "Please investigate" -smtpServer qa-smtp1.ts.com
        }
    }
    else {
        send-mailmessage -to "user<cc@cc.com>" -from "DRfile1 monitor <monitor@cc.com>" -subject ($source + " does not exist") -body "Please investigate" -smtpServer qa-smtp1.ts.com
    }
}

###############################    INPUT    ###############################################

$threshold = 2 #gb unit

$check_days = -3 , -2 , -1 # 3 days ago, 2 days ago, and yesterday

$the_source = "\\nas\c$"

$the_dest = "G:\dest"

############################    CHECK BACKUPS    ###########################################

foreach ($date in $check_days) {
    $temp_rel_path = find_relative_path ($date)
    $temp_source = $the_source + $temp_rel_path
    $temp_dest = $the_dest + $temp_rel_path

    check_backup $temp_source $temp_dest $threshold $temp_dest 

}

###############################    THE END    ###############################################


<#


$copy_source = "C:\Users\user\Desktop\test-bk-asdafsa"       
$copy_dest = "G:\test-bk-asdafsa"                              

$status_code = check_backup $copy_source $copy_dest $threshold

if ($status_code -eq 1) {
    send-mailmessage -to "user <user@cc.com>" -from "DRfile1 monitor <monitor@cc.com>" -subject "Subject" -body "Please investigate." -smtpServer smtp.cc.com
}

write-host "Status code: " -NoNewline $status_code


#   check backup from 3 days ago


#   check backup from 2 days ago


#   check yesterday backup



#>
 
<#

$get_date = (get-date ).AddDays(-1)
$year = $get_date.Year
$month = $get_date.Month
$date = $get_date.Day


$copy_source_prefix = "\\nas\path"
$copy_dest_prefix = "\\nas\e\path"

$copy_source_path = $copy_source_prefix +"\"+ $year +"\"+ $month +"\"+ $date
$copy_dest_path = $copy_dest_prefix +"\"+ $year +"\"+ $month +"\"+ $date


Write-Host $copy_source_path
Write-Host $copy_dest_path

#>
