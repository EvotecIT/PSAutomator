Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration.xml' {
    Trigger -Name 'Reenabling my users for testing purposes' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Ignore -Name 'Ignore Windows Email Address if Empty or null' -Ignore MatchingEmptyOrNull -Value EmailAddress |
        Action -Name 'Enable AD Account' -ActiveDirectory AccountEnable |
        Action -Name 'Add Domain Admins' -ActiveDirectory AccountAddGroupsSpecific -Value 'Users Disabled'
}