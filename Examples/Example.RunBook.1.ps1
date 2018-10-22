Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' -Status Enable -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'OU Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz'
}
