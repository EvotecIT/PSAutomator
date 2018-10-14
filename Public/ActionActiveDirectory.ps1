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
    Write-Color -Text '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ', $Object.Trigger.Trigger, ' with value ', $Object.Trigger.Value -Color Green, White, Green, White, Green, White, Green, White, Green -StartSpaces 4
    foreach ($User in $Users) {
        $WriteSucesss = @{
            Text        = '[#] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' done.'
            Color       = 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan'
            StartSpaces = 6
        }
        $WriteSkip = @{
            Text        = '[#] ', 'Execution ', $Name, ' on account ', $User.UserPrincipalName, ' skipped.'
            Color       = 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
            StartSpaces = 6
        }
        $WriteStatus = @{
            StartSpaces = 10
        }

        $Result = switch ( $Action ) {
            AccountAddGroupsSpecific {
                $CommandOutput = Add-ADUserGroups -User $User -Groups $ActionValue
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatus -Text '[+] ', 'Successfully processed ', $Output.Output
                        } else {
                            Write-Color @WriteStatus -Text '[-] ', 'Skipped ', $Output.Output
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountDisable {
                $Status = Set-ADUserStatus -User $User -Option Disable
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountEnable {
                $Status = Set-ADUserStatus -User $User -Option Enable
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountHideInGAL {
                $Status = Set-ADUserSettingGAL -User $User -Option Hide
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountShowInGAL {
                $Status = Set-ADUserSettingGAL -User $User -Option Show
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsAll {
                $Status = Remove-ADUserGroups -User $User -All
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsSecurity {
                $Status = Remove-ADUserGroups -User $User -GroupCategory Security
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsDistribution {
                $Status = Remove-ADUserGroups -User $User -GroupCategory Distribution
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsDomainLocal {
                $Status = Remove-ADUserGroups -User $User -GroupScope DomainLocal
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsGlobal {
                $Status = Remove-ADUserGroups -User $User -GroupScope Global
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsUniversal {
                $Status = Remove-ADUserGroups -User $User -GroupScope Universal
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRemoveGroupsSpecific {
                $Status = Remove-ADUserGroups -User $User -Groups $ActionValue
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountRename {
                $Status = Set-ADUserName -User $User -Option $ActionValue.Where -TextToAdd $ActionValue.Text
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
        }
    }
    return $Object
}