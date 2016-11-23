$input_file = "C:\Users\pcs.txt.new"
foreach ($line in Get-Content -Path $input_file) {
    #$line
    $trim = $line.Trim()
    $trim | Out-File -Append -FilePath "C:\Users\Ninite\pcs-no-spaces.txt"
}
