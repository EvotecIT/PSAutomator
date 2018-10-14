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
        $Sucesss = @{
            Text        = '[+] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.'
            Color       = 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan'
            StartSpaces = 4
        }
        $Skip = @{
            Text        = '[-] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.'
            Color       = 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
            StartSpaces = 4
        }
        $Result = switch ( $Action ) {
            AccountDisable {
                $Status = Set-ADUserStatus -User $User -Option Disable
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountEnable {
                $Status = Set-ADUserStatus -User $User -Option Enable
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountHideInGAL {
                $Status = Set-ADUserSettingGAL -User $User -Option Hide
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountShowInGAL {
                $Status = Set-ADUserSettingGAL -User $User -Option Show
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsAll {
                $Status = Remove-ADUserGroups -User $User -All
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsSecurity {
                $Status = Remove-ADUserGroups -User $User -GroupCategory Security
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsDistribution {
                $Status = Remove-ADUserGroups -User $User -GroupCategory Distribution
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsDomainLocal {
                $Status = Remove-ADUserGroups -User $User -GroupScope DomainLocal
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsGlobal {
                $Status = Remove-ADUserGroups -User $User -GroupScope Global
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsUniversal {
                $Status = Remove-ADUserGroups -User $User -GroupScope Universal
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRemoveGroupsSpecific {
                $Status = Remove-ADUserGroups -User $User -Groups $BlockActiveDirectory.AccountRemoveGroupsSpecific
                if ($Status) { Write-Color @Sucesss } else { Write-Color @Skip }
            }
            AccountRename {
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