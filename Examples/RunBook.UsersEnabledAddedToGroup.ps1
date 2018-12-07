Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration.xml' {
    Trigger -Name 'Reenabling my users for testing purposes' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Condition -Name 'Ignore Windows Email Address if Empty or null' -Condition EmptyOrNull -Value EmailAddress |
        Action -Name 'Enable AD Account' -ActiveDirectory AccountEnable -WhatIf |
        Action -Name 'Add user to Disabled Users' -ActiveDirectory AccountAddGroupsSpecific -Value 'Disabled Users' -WhatIf
}