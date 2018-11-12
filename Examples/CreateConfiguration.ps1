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
                SessionName = 'Active Directory'
            }
            Exchange        = [ordered] @{
                Credentials    = [ordered] @{
                    UserName         = '' # if Kerberos leave empty (domain joined computers usually)
                    Password         = '' # same as above
                    PasswordAsSecure = $true
                    PasswordFromFile = $true
                }
                Use            = $false
                Prefix         = ''

                SessionName    = 'Exchange On-Premises'
                Authentication = 'Kerberos'
                ConnectionURI  = 'http://ex2013x3.ad.evotec.xyz/PowerShell'
                LeaveOpen      = $true

            }
        }
        Office365  = [ordered] @{
            Credentials    = [ordered] @{
                Username         = 'przemyslaw.klys@evotec.pl'
                Password         = 'C:\Support\Important\Password-O365-Evotec.txt'
                PasswordAsSecure = $true
                PasswordFromFile = $true
            }
            Azure          = [ordered] @{
                Use         = $true
                SessionName = 'O365 Azure MSOL' # MSOL
            }
            AzureAD        = [ordered] @{
                Use         = $true
                SessionName = 'O365 Azure AD' # Azure
                Prefix      = ''
            }
            ExchangeOnline = [ordered] @{
                Use            = $true
                Authentication = 'Basic'
                ConnectionURI  = 'https://outlook.office365.com/powershell-liveid/'
                Prefix         = 'O365'
                SessionName    = 'O365 Exchange'
            }
            Teams = [ordered] @{
                Use         = $true
                Prefix      = ''
                SessionName = 'O365 Teams'
            }
        }
    }
}

New-PSAutomatorConfiguration -Configuration $Configuration -Path 'Examples\MyConfiguration1.xml'