Import-Module activedirectory


$users = Import-csv C:\Scripts\input\users.csv

foreach ($user in $users) 
{

$displayname = $user.Firstname + " " + $user.Lastname
$firstname = $user.Firstname
$lastname = $user.Lastname
$SAM = $user.SAM
$UPN = $user.Sam + "@" + $user.Maildomain
$Description = $user.Description
$OU = $user.OU
$expiration = $user.expires
$Password = $User.password
New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName $SAM -UserPrincipalName $UPN -GivenName $UserFirstname -Surname $UserLastname -Description $Description -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $true -AccountExpirationDate $expiration -server domain.lcl          
}
