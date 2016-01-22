# Connect to On Premises Exchange
$OnPremiseSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://b1-pexchch01.ultainc.lcl/powershell/ -Authentication Kerberos
Import-PSSession $OnPremiseSession
Write-Host "on prem session connected" -BackgroundColor darkblue



$Users = Get-ADUser -SearchBase "OU=GM's,OU=Field Users,OU=Users,OU=Corporate,OU=ULTA-Managed,DC=ultainc,DC=lcl" -Filter * -Properties displayname,department,sAMAccountName | where {$_.displayname -like '*, gm*' -and $_.department -eq $null} | select displayname,department,samaccountname #| Export-csv C:\Scripts\output\adoutput_GM.csv

foreach ($User in $users)
{
Set-aduser $User.sAmAccountName -add @{department="Store"}

    if ($user.department -ne $null) 
    {
    Get-remotemailbox $user.sAMAccountName | Set-remoteMailbox -EmailAddressPolicyEnabled $false
    Start-sleep -second 2
    Get-remotemailbox $user.sAMAccountName | Set-remoteMailbox -EmailAddressPolicyEnabled $true
    } 
}