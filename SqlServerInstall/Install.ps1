Set-ExecutionPolicy unrestricted
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$serviceAccount = "NT Service\MSSQL`$$($instanceName)"
if ($instanceName -eq "MSSQLSERVER")
{
    $serviceAccount = "NT Service\MSSQLSERVER"
}
$cmd  = @"
"$dir\SQLServer2017-SSEI-Expr.exe" /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION=install  /ROLE=AllFeatures_WithDefaults  /INSTANCENAME=$($instanceName) /SQLSVCACCOUNT="$($serviceAccount)"  
"@
write-host "Installing"
write-host $cmd
& cmd.exe /c $cmd