#Set variables
$path = "G:\e4t-data\orga"
$filename = "seznamACL.txt"
$date = Get-Date
#Place Headers on out-put file
$list = "Permissions for directories in: $Path"
$list | format-table | Out-File "C:\Powershell\Results\$filename"
$datelist = "Report Run Time: $date"
$datelist | format-table | Out-File -append "C:\Powershell\Results\$filename"
$spacelist = " "
$spacelist | format-table | Out-File -append "C:\Powershell\Results\$filename"
#Populate Folders Array
[Array] $folders = Get-ChildItem -path $path -force -recurse | Where {$_.PSIsContainer}
#Process data in array
ForEach ($folder in [Array] $folders)
{
#Convert Powershell Provider Folder Path to standard folder path
$PSPath = (Convert-Path $folder.pspath)
$list = ("Path: $PSPath")
$list | format-table | Out-File -append "C:\Powershell\Results\$filename"
Get-Acl -path $PSPath | Format-List -property AccessToString | Out-File -append "C:\Powershell\Results\$filename"
} #end ForEach
