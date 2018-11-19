@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'PSAutomator.psm1'

    # Version number of this module.
    ModuleVersion     = '0.0.3'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = '1be9e392-28cb-4ac6-aba7-b924defbf9da'

    # Author of this module
    Author            = 'Przemyslaw Klys'

    # Company or vendor of this module
    CompanyName       = 'Evotec'

    # Copyright statement for this module
    Copyright         = 'Evotec (c) 2018. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = "PowerShell Module is new approach to onboarding, offboarding and business as usual processes running in companies infrastructure. Usually each company has different rules, different approaches on how processes should look like and this module takes an easy approach that's similar to what you can find in services like IFTTT or Microsoft Flow"

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.1'

    RequiredModules   = @('PSSharedGoods', 'PSWriteColor')

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    ScriptsToProcess  = @(
        'Enums\ActionAD.ps1',
        'Enums\ActionAzureAD.ps1',
        'Enums\ActionExchange.ps1',
        'Enums\ActionExchangeOnline.ps1',
        'Enums\Condition.ps1',
        'Enums\Connect.ps1',
        'Enums\Ignore.ps1',
        'Enums\TriggerComputer.ps1',
        'Enums\TriggerGroup.ps1',
        'Enums\TriggerUserAD.ps1',
        'Enums\TriggerUserAzureAD.ps1'
    )

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    #FunctionsToExport = @('Action', 'Connect', 'Condition', 'Ignore', 'Service', 'Trigger', 'New-PSAutomatorConfiguration')
    FunctionsToExport = '*'
    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @('ActiveDirectory', 'Offboarding', 'Onboarding', 'Windows')

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/EvotecIT/PSAutomator'

            # A URL to an icon representing this module.
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2018/10/PSAutomator.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}