Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Remote Mailbox' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'OU Offboarded Users' -User Filter -Value @{ Filter = '*'; SearchBase = 'OU=Production,DC=ad,DC=evotec,DC=xyz' }  |
        Condition -Name 'Member of Disabled Users' -Condition GroupMembership -Value @{ Field = 'Name'; Operator = 'eq'; Value = 'Disabled Users' } |
        Condition -Name 'Not member of OU' -Condition OrganizationalUnit -Value @{ Field = 'DistinguishedName'; Operator = 'notlike'; Valuee = 'Users-Offboarded*' } |
        Condition -Name 'Ignore MyUser Account' -Condition Field -Value @{ Field = 'UserPrincipalName'; Operator = 'notlike'; Value = 'myuser*' } |
        Condition |
        Action -Name 'Make User Snapshot' -ActiveDirectory AccountSnapshot -Value 'C:\Users\pklys\Desktop\MyExport' -WhatIf
}