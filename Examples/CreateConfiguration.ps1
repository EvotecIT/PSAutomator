$Configuration = [ordered] @{
    Prettify = [ordered] @{
        CompanyName    = 'Evotec'
        Debug          = @{
            Verbose = $false
        }
        DisplayConsole = @{
            Standard = @{
                ShowTime   = $true
                LogFile    = ""
                TimeFormat = "yyyy-MM-dd HH:mm:ss"
            }
        }
    }
    Services = [ordered] @{
        OnPremises = [ordered] @{
            ActiveDirectory = [ordered] @{
                Credentials = [ordered] @{
                    Username         = ''
                    Password         = ''
                    PasswordAsSecure = $true
                    PasswordFromFile = $true
                }
                Use         = $true
                Prefix      = ''
                SessionName = 'ActiveDirectory'
            }
            Exchange        = [ordered] @{
                Credentials    = [ordered] @{
                    UserName         = '' # if Kerberos leave empty (domain joined computers usually)
                    Password         = '' # same as above
                    PasswordAsSecure = $true
                    PasswordFromFile = $true
                }
                Use            = $true
                Prefix         = ''

                SessionName    = 'ExchangeLocal'
                Authentication = 'Kerberos'
                ConnectionURI  = 'http://ex2013x3.ad.evotec.xyz/PowerShell'
                LeaveOpen      = $true

            }
        }
        Office365  = [ordered] @{
            Credentials    = [ordered] @{
                Username         = 'przemyslaw.klys@evotec.pl'
                Password         = 'C:\Support\GitHub\PSWinDocumentation\Ignore\MySecurePassword.txt'
                PasswordAsSecure = $true
                PasswordFromFile = $true
            }
            Azure          = [ordered] @{
                Use         = $false
                Prefix      = ''
                SessionName = 'O365Azure' # MSOL
            }
            AzureAD        = [ordered] @{
                Use         = $false
                SessionName = 'O365AzureAD' # Azure
                Prefix      = ''
            }
            ExchangeOnline = [ordered] @{
                Use            = $false
                Authentication = 'Basic'
                ConnectionURI  = 'https://outlook.office365.com/powershell-liveid/'
                Prefix         = 'O365'
                SessionName    = 'O365Exchange'
            }
        }
    }
}

New-PSAutomatorConfiguration -Configuration $Configuration -Path 'Examples\MyConfiguration1.xml'