$date = Get-Date 

for($i=1; $i -le 7; $i++)
{        
    if($date.AddDays($i).DayOfWeek -eq 'Friday')
    {        
        $deadline =
        $date.AddDays($i)  | Get-Date -Format D
    }
}

Write-Host $deadline
