Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' -Status Enable -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'Synchronized Users from AD' -UserAzureAD Synchronized |
        Action -Name 'Disable Synchronized Users' -AzureActiveDirectory AccountDisable -WhatIf
}
