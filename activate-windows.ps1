$list = "12r2coretest"
$key = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"

foreach ($name in $list) {
    Write-Host $name
    try {       
    Invoke-Command -ComputerName $name -ScriptBlock {param($1) slmgr /ipk $1}  -ArgumentList $key
    Invoke-Command -ComputerName $name -ScriptBlock {slmgr /ato}
    }
    catch {
        Write-Host -ForegroundColor red $name "error"       
    }
}
