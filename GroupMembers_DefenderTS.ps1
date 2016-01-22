#9/24/2015
#Justin Almli
#Creates Directory
#Gets AD group members 
#Gets AD User attributes
#Converts logon time stamps from windows format to readable format
#Exports to CSV


Import-Module Activedirectory

$groups = "2-Factor VPN", "SSLVPN_RETAIL_Connect", "SSLVPN_ECOM_Connect", "SSLVPN_CORP_Connect"
$credential = Get-Credential
$targetdir = "c:\VPNSecurity Logins"


If(!(Test-Path -Path $TARGETDIR )){
    New-Item -ItemType directory -Path $TARGETDIR
}


$(
    ForEach ($member in $groups) {

        Get-ADGroupMember -identity $member -Credential $credential | 
        Where {$_.ObjectClass -eq 'user'} | 
        Get-ADUser -Properties Name,Defender-lastlogon,defender-userTokenData | 
        Select -unique Name,@{n='Defender-lastlogon';e={[DateTime]::FromFileTime($_.'Defender-lastlogon')}},@{name=”defender-userTokenData”;expression={$_.'defender-userTokenData' -join “,”}}
        
        } 

) | Sort-Object name -Unique | Export-Csv 'C:\VPNSecurity Logins\VPNSecurity_Login.csv' -NoTypeInformation


