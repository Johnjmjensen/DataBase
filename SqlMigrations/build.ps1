Set-ExecutionPolicy unrestricted
$Server="localhost"
$Database="master"
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Invoke-Sqlcmd -InputFile "$dir/CreateDB/1_createDataBase.sql" -ServerInstance $Server -Database $Database -ErrorAction 'Stop' -verbose -QueryTimeout 1800 # 30min
Write-Host  "$dir/CreateDB/1_createDataBase.sql commited" 
$DatabaseP="Portfolio"
foreach ($file in Get-ChildItem $dir -Filter "*.sql" | sort-object  -Property name)
{
Invoke-Sqlcmd -InputFile $dir/$file -ServerInstance $Server -Database $DatabaseP -ErrorAction 'Stop' -verbose -QueryTimeout 1800 # 30min
Write-Host  "$dir/$file commited" 
}