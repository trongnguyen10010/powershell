$computers = Get-Content -Path "C:\Users\backup_project\workstations.txt"

foreach ($pc in $computers) {
    if ($pc.ToString().EndsWith("2")) {
        $index = $pc.ToString().IndexOf("2")
        $username = $pc.ToString().Substring(0,$index)
        
    }
    else {
        $pc
    }
}
