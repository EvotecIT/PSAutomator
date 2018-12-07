Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Offboarding' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'OU Offboarded Users' -User Filter -Value @{ Filter = "UserPrincipalName -eq 'przemyslaw.klys@ad.evotec.xyz'"; SearchBase = 'OU=Users,OU=Production,DC=ad,DC=evotec,DC=xyz' }  |
        Condition -Name 'No conditions' |
        Condition -Name 'Ignore Windows Email Address if Empty or null' -Condition EmptyOrNull -Value EmailAddress |
        Action -Name 'Make User Snapshot' -ActiveDirectory AccountSnapshot -Value 'C:\Users\pklys\Desktop\MyExport' -WhatIf
}