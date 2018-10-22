Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration.xml' {
    Trigger -Name 'OU Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Ignore -Name 'Ignore Windows Email Address if Empty or null' -Ignore MatchingEmptyOrNull -Value EmailAddress |
        Action -Name 'Make User Snapshot' -ActiveDirectory AccountSnapshot -Value 'C:\Users\pklys\Desktop\MyExport' |
        Action -Name 'Disable AD Account' -ActiveDirectory AccountDisable |
        Action -Name 'Hide account in GAL' -ActiveDirectory AccountHideInGAL |
        Action -Name 'Rename Account' -ActiveDirectory AccountRename -Value @{ Action = 'AddText'; Where = 'After'; Text = ' (offboarded)'; } |
        Action -Name 'Remove all security groups' -ActiveDirectory AccountRemoveGroupsSecurity
}