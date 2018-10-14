Function ActionActiveDirectory {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [AutomatorActionAD] $Action,
        [Object] $ActionValue
    )
    $Trigger = switch ($Object.Trigger.Trigger) {
        OrganizationalUnit {
            $Users = Get-ActiveDirectoryUsersByOU -OrganizationalUnit $Object.Trigger.Value
        }
    }
    $CountUsers = Get-ObjectCount -Object $Users
    Write-Color -Text '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ', $Object.Trigger.Trigger, ' with value ', $Object.Trigger.Value -Color Green, White, Green, White, Green, White, Green, White, Green -StartSpaces 2
    foreach ($User in $Users) {
        $Result = switch ( $Action ) {
            AccountDisable {
                $Status = Set-ADUserStatus -User $User -Option Disable
                if ($Status) {
                    Write-Color -Text '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.' -Color Cyan, White, Cyan, White, Cyan, White, Cyan, White, Cyan -StartSpaces 4
                } else {
                    Write-Color -Text '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.' -Color Yellow, White, Yellow, White, Yellow, White, Yellow, White, Yellow -StartSpaces 4
                }
            }
            AccountEnable {
                $Status = Set-ADUserStatus -User $User -Option Enable
                if ($Status) {
                    Write-Color -Text '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.' -Color Cyan, White, Cyan, White, Cyan, White, Cyan, White, Cyan -StartSpaces 4
                } else {
                    Write-Color -Text '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.' -Color Yellow, White, Yellow, White, Yellow, White, Yellow, White, Yellow -StartSpaces 4
                }
            }
            AccountHideInGAL {
                #Write-Color -Text '[+] Action ', $Object.Trigger.Trigger -Color Cyan -StartSpaces 2
                #Write-Color -Text '[-] Ignore ', $Object.Ignore.Name -StartSpaces 2
                $Status = Set-ADUserSettingGAL -User $User -Option Hide
                if ($Status) {
                    Write-Color -Text '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.' -Color Cyan, White, Cyan, White, Cyan, White, Cyan, White, Cyan -StartSpaces 4
                } else {
                    Write-Color -Text '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.' -Color Yellow, White, Yellow, White, Yellow, White, Yellow, White, Yellow -StartSpaces 4
                }
            }
            AccountShowInGAL {
                $Status = Set-ADUserSettingGAL -User $User -Option Show
                if ($Status) {
                    Write-Color -Text '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.' -Color Cyan, White, Cyan, White, Cyan, White, Cyan, White, Cyan -StartSpaces 4
                } else {
                    Write-Color -Text '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.' -Color Yellow, White, Yellow, White, Yellow, White, Yellow, White, Yellow -StartSpaces 4
                }
            }
            AccountRename {
                #Write-Color -Text '[+] Action ', $Object.Trigger.Trigger -Color DarkMagenta -StartSpaces 2
                $Status = Set-ADUserName -User $User -Option $ActionValue.Where -TextToAdd $ActionValue.Text
                if ($Status) {
                    Write-Color -Text '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.' -Color Cyan, White, Cyan, White, Cyan, White, Cyan, White, Cyan -StartSpaces 4
                } else {
                    Write-Color -Text '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.' -Color Yellow, White, Yellow, White, Yellow, White, Yellow, White, Yellow -StartSpaces 4
                }
            }
        }
    }
    return $Object
}