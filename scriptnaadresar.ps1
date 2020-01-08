$ADUsers = Get-ADUser -Filter * -SearchBase "OU=Standard, OU=DQ, OU=Domain Users,  DC=skoda, DC=vwg" -Properties Enabled, Givenname, Surname, EmployeeNumber, sAMAccountname
$rok = get-date –f yyyy #automaticky si bere rok z datumu
$root = "D:\MountPoint\orga\E4\TRAVEL_ACCOUNTING\{0}\" -f $rok  #cesta musi koncit lomitkem ! rok se autoaticky meni
Write-Output $root

ForEach ($ADUser in $ADUsers)
{
    $adresar = "{0}_{1}_{2}" -f $ADUser.Surname,$ADUser.GivenName,$ADUser.EmployeeNumber
    $username = "{0}" -f $ADUser.sAMAccountname
    $cesta= "{0}{1}" -f $root,$adresar
    if(!$username.Contains(".del")) {
        if(!(Test-Path -Path $cesta )){
                New-Item $cesta -type directory
                $acl = Get-Acl "$cesta"
                $args = "$username", 'ReadAndExecute', 'ContainerInherit,ObjectInherit', 'None', 'Allow'
                $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $args
                $acl.SetAccessRule($accessRule)
                $acl | Set-Acl "$cesta"
         }         
    }
}