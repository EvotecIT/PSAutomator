Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Offboarding' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration.xml' {
    Trigger -Name 'OU Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Condition -Name 'Ignore Windows Email Address if Empty or null' -Condition EmptyOrNull -Value 'EmailAddress' |
        Action -Name 'Make User Snapshot' -ActiveDirectory AccountSnapshot -Value 'C:\Users\pklys\Desktop\MyExport' -Whatif |
        Action -Name 'Disable AD Account' -ActiveDirectory AccountDisable -WhatIf |
        Action -Name 'Hide account in GAL' -ActiveDirectory AccountHideInGAL -WhatIf  |
        Action -Name 'Remove all security groups' -ActiveDirectory AccountRemoveGroupsSecurity -WhatIf |
        Action -Name 'Rename Account' -ActiveDirectory AccountRename -Value @{ Action = 'AddText'; Where = 'After'; Fields = 'DisplayName', 'Name'; Text = ' (offboarded)'; } -WhatIf
}