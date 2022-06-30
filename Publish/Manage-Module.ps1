Clear-Host

$Configuration = @{
    Information = @{
        ModuleName        = 'PSAutomator'
        DirectoryProjects = 'C:\Support\GitHub'
        Manifest          = @{
            # Minimum version of the Windows PowerShell engine required by this module
            PowerShellVersion = '5.1'

            ModuleVersion     = '0.0.3'

            # ID used to uniquely identify this module
            GUID              = '1be9e392-28cb-4ac6-aba7-b924defbf9da'
            # Author of this module
            Author            = 'Przemyslaw Klys'
            # Company or vendor of this module
            CompanyName       = 'Evotec'
            # Copyright statement for this module
            Copyright         = '(c) 2018 Przemyslaw Klys. All rights reserved.'
            # Description of the functionality provided by this module
            Description       = "PowerShell Module is new approach to onboarding, offboarding and business as usual processes running in companies infrastructure. Usually each company has different rules, different approaches on how processes should look like and this module takes an easy approach that's similar to what you can find in services like IFTTT or Microsoft Flow"
            # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags              = @('ActiveDirectory', 'Offboarding', 'Onboarding', 'Windows')

            IconUri           = 'https://evotec.xyz/wp-content/uploads/2018/10/PSAutomator.png'

            ProjectUri        = 'https://github.com/EvotecIT/PSAutomator'

            RequiredModules   = @('PSSharedGoods', 'PSWriteColor')

        }
    }
    Options     = @{
        Merge             = @{
            Sort           = 'None'
            FormatCodePSM1 = @{
                Enabled           = $true
                RemoveComments    = $true
                FormatterSettings = @{
                    IncludeRules = @(
                        'PSPlaceOpenBrace',
                        'PSPlaceCloseBrace',
                        'PSUseConsistentWhitespace',
                        'PSUseConsistentIndentation',
                        'PSAlignAssignmentStatement',
                        'PSUseCorrectCasing'
                    )

                    Rules        = @{
                        PSPlaceOpenBrace           = @{
                            Enable             = $true
                            OnSameLine         = $true
                            NewLineAfter       = $true
                            IgnoreOneLineBlock = $true
                        }

                        PSPlaceCloseBrace          = @{
                            Enable             = $true
                            NewLineAfter       = $false
                            IgnoreOneLineBlock = $true
                            NoEmptyLineBefore  = $false
                        }

                        PSUseConsistentIndentation = @{
                            Enable              = $true
                            Kind                = 'space'
                            PipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
                            IndentationSize     = 4
                        }

                        PSUseConsistentWhitespace  = @{
                            Enable          = $true
                            CheckInnerBrace = $true
                            CheckOpenBrace  = $true
                            CheckOpenParen  = $true
                            CheckOperator   = $true
                            CheckPipe       = $true
                            CheckSeparator  = $true
                        }

                        PSAlignAssignmentStatement = @{
                            Enable         = $true
                            CheckHashtable = $true
                        }

                        PSUseCorrectCasing         = @{
                            Enable = $true
                        }
                    }
                }
            }
            FormatCodePSD1 = @{
                Enabled        = $true
                RemoveComments = $false
            }
            Integrate      = @{
                ApprovedModules = 'PSWriteColor', 'Connectimo', 'PSUnifi', 'PSWebToolbox', 'PSMyPassword'
            }
        }
        Standard          = @{
            FormatCodePSM1 = @{

            }
            FormatCodePSD1 = @{
                Enabled = $true
                #RemoveComments = $true
            }
        }
        PowerShellGallery = @{
            ApiKey   = 'C:\Support\Important\PowerShellGalleryAPI.txt'
            FromFile = $true
        }
        GitHub            = @{
            ApiKey   = 'C:\Support\Important\GithubAPI.txt'
            FromFile = $true
            UserName = 'EvotecIT'
            #RepositoryName = 'PSPublishModule' # not required, uses project name
        }
        Documentation     = @{
            Path       = 'Docs'
            PathReadme = 'Docs\Readme.md'
        }
    }
    Steps       = @{
        BuildModule        = @{  # requires Enable to be on to process all of that
            Enable           = $true
            DeleteBefore     = $false
            Merge            = $true
            MergeMissing     = $true
            SignMerged       = $true
            Releases         = $true
            ReleasesUnpacked = $false
            RefreshPSD1Only  = $false
        }
        BuildDocumentation = $false
        ImportModules      = @{
            Self            = $true
            RequiredModules = $false
            Verbose         = $false
        }
        PublishModule      = @{  # requires Enable to be on to process all of that
            Enabled      = $false
            Prerelease   = ''
            RequireForce = $false
            GitHub       = $false
        }
    }
}

New-PrepareModule -Configuration $Configuration -Verbose