#Alias Paramater
param(
[string]$alias
)


#Please establish an O365 connection before running the script
Write-Host "Please establish an O365 connection if you have not done so" -BackgroundColor DarkBlue
Start-Sleep 1

#Establish On-Premise Exchange Connection
#Connect to On Premises Exchange
$OnPremiseSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://server.domain.lcl/powershell/ -Authentication Kerberos
Import-PSSession $OnPremiseSession
Write-Host "on prem session connected" -BackgroundColor darkblue

#Gets GUID of O365 User
$RGuid = Get-CloudRemoteMailbox $alias | Format-List ExchangeGUID 

#List GUID of O365 User
Write-Host "$RGuid" -BackgroundColor DarkRed
Start-Sleep 2

#Create Remote Contact onPremise
Enable-remotemailbox $alias -remoteroutingaddress "$alias@domain.mail.onmicrosoft.com"
Write-Host "$alias@domain.mail.onmicrosoft.com has been created"

#Gets GUID of Newly created onPremise user
$LGuid = Get-RemoteMailbox $alias | Format-List ExchangeGuid

#Lists Guid of Newly created onPremis user
Write-Host "$LGuid" -BackgroundColor DarkRed
Start-Sleep 2

#Sets onPremise Guid to match O365 Guid
Write-Host "Setting GUID on New Remote Contact"
Set-RemoteMailbox $alias -ExchangeGuid $RGuid 


#Verify GUIDS onPremise and O365

$RGuid = Get-RemoteMailbox $alias | Format-List ExchangeGuid
$LGuid = Get-CloudRemoteMailbox $alias | Format-List ExchangeGUID
Write-Host "Local GUID is $LGuid" -BackgroundColor DarkRed
Write-Host "Remote GUID is $RGuid" -BackgroundColor DarkRed

Write-Host "GUIDS should match"






