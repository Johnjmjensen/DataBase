Set-ExecutionPolicy unrestricted
$Server="localhost"
$Database="master"
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
foreach ($file in Get-ChildItem $dir -Filter "*.sql" | sort-object  -Property name)
{
Invoke-Sqlcmd -InputFile $dir/$file -ServerInstance $Server -Database $Database -ErrorAction 'Stop' -verbose -QueryTimeout 1800 # 30min
Write-Host  "$dir/$file commited" 
}

   
