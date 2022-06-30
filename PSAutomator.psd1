@{
    AliasesToExport   = 'Ignore'
    Author            = 'Przemyslaw Klys'
    CmdletsToExport   = @()
    CompanyName       = 'Evotec'
    Copyright         = '(c) 2018 Przemyslaw Klys. All rights reserved.'
    Description       = 'PowerShell Module is new approach to onboarding, offboarding and business as usual processes running in companies infrastructure. Usually each company has different rules, different approaches on how processes should look like and this module takes an easy approach that''s similar to what you can find in services like IFTTT or Microsoft Flow'
    FunctionsToExport = @('New-PSAutomatorConfiguration', 'Action', 'Condition', 'Connect', 'Service', 'Trigger')
    GUID              = '1be9e392-28cb-4ac6-aba7-b924defbf9da'
    ModuleVersion     = '0.0.3'
    PowerShellVersion = '5.1'
    PrivateData       = @{
        PSData = @{
            Tags       = @('ActiveDirectory', 'Offboarding', 'Onboarding', 'Windows')
            ProjectUri = 'https://github.com/EvotecIT/PSAutomator'
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2018/10/PSAutomator.png'
        }
    }
    RequiredModules   = @('PSSharedGoods', 'PSWriteColor')
    RootModule        = 'PSAutomator.psm1'
}