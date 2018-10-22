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
        ActiveDirectory = [ordered] @{

        }
        Exchange        = [ordered] @{
            Credentials   = [ordered] @{
                UserName = '' # if Kerberos leave empty (domain joined computers usually)
                Password = '' # same as above
            }
            Configuration = [ordered] @{
                Use            = $true
                Authentication = 'Kerberos'
                SessionName    = 'ExchangeLocal'
                ConnectionURI  = 'http://ex2013x3.ad.evotec.xyz/PowerShell'
                LeaveOpen      = $true
            }
        }
        Office365       = [ordered] @{
            Credentials    = [ordered] @{
                Username         = 'przemyslaw.klys@evotec.pl'
                Password         = 'C:\Support\GitHub\PSWinDocumentation\Ignore\MySecurePassword.txt'
                PasswordAsSecure = $true
                PasswordFromFile = $true
            }
            Azure          = [ordered] @{
                Use         = $true
                Prefix      = ''
                SessionName = 'O365Azure' # MSOL
            }
            AzureAD        = [ordered] @{
                Use         = $true
                SessionName = 'O365AzureAD' # Azure
                Prefix      = ''
            }
            ExchangeOnline = [ordered] @{
                Use            = $true
                Authentication = 'Basic'
                ConnectionURI  = 'https://outlook.office365.com/powershell-liveid/'
                Prefix         = 'O365'
                SessionName    = 'O365Exchange'
            }
        }
    }
}

New-PSAutomatorConfiguration -Configuration $Configuration -Path 'Examples\MyConfiguration1.xml'