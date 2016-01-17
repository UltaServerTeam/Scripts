#Gets GUID of O365 User
$RGuid = Get-CloudRemoteMailbox <alias> | Format-List ExchangeGUID 

#Create Remote Contact On Premise
Enalbe-remotemailbox <alias> -remoteroutingaddress "alias@ultainc.mail.onmicrosoft.com"

