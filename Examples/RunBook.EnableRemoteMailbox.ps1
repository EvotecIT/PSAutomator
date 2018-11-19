Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Remote Mailbox' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'OU Offboarded Users' -User Filter -Value @{ Filter = '*'; SearchBase = 'OU=Production,DC=ad,DC=evotec,DC=xyz' }  |
        Condition -Name 'No conditions' -Condition GroupMembership -Value @{ Field = 'Name'; Operator = 'eq'; Value = 'Disabled Users' } |
        Condition | #  -Name 'Ignore Windows Email Address if Empty or null' -Condition EmptyOrNull -Value EmailAddress |
        Condition | # -Name 'Ignore Synchronization Account' -Condition Fields -Value @{ Field = 'UserPrincipalName'; Operator = 'notlike'; Value = 'Sync_ADConnect*' } |
        Action -Name 'Make User Snapshot' -ActiveDirectory AccountSnapshot -Value 'C:\Users\pklys\Desktop\MyExport' -WhatIf
}