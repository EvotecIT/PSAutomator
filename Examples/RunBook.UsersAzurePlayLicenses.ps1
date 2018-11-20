Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Removing Licenses from Some Users' -Status Enable -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'All users in Azure AD' -UserAzureAD All |
        Condition -Name 'Ignore Synchronization Account' -Condition Field -Value @{ Field = 'UserPrincipalName'; Operator = 'notlike'; Value = 'Sync_ADConnect*' } |
        Condition -Name 'Only Licensed Users' -Condition Field -Value @{ Field = 'IsLicensed'; Operator = 'eq'; Value = $true } |
        Condition -Name 'Only Synchronized Users' -Condition Field -Value @{ Field = 'LastDirSyncTime'; Operator = 'ne'; Value = $null } |
        Action -Name 'Remove all licenses' -AzureActiveDirectory RemoveLicenseAll #-WhatIf
}

return

Service -Name 'Adding licenses to Some users' -Status Enable -ConfigurationPath 'C:\Support\GitHub\PSAutomator\Examples\MyConfiguration1.xml' {
    Trigger -Name 'All unlicensed users in Azure AD' -UserAzureAD Unlicensed |
        Condition -Name 'Ignore Synchronization Account' -Condition Field -Value @{ Field = 'UserPrincipalName'; Operator = 'notlike'; Value = 'Sync_ADConnect*' } |
        Condition -Name 'Only Synchronized Users' -Condition Field -Value @{ Field = 'LastDirSyncTime'; Operator = 'ne'; Value = $null } |
        Action -Name 'Set usage location' -AzureActiveDirectory SetField -Value @{ Field = 'UsageLocation'; Value = 'PL' } |
        Action -Name 'Add business essentials license' -AzureActiveDirectory AddLicense -Value 'evotecpoland:O365_BUSINESS_ESSENTIALS'  |
        Action -Name 'Add flow license' -AzureActiveDirectory AddLicense -Value 'evotecpoland:FLOW_FREE'
}

<#
evotecpoland:FLOW_FREE
evotecpoland:STANDARDPACK

AccountSkuId                          ActiveUnits WarningUnits ConsumedUnits
------------                          ----------- ------------ -------------
evotecpoland:DESKLESSPACK             2           0            2
evotecpoland:FLOW_FREE                10000       0            1
evotecpoland:O365_BUSINESS_ESSENTIALS 2           0            2
evotecpoland:STANDARDPACK             1           0            1

#>