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
        GroupMembership {
            $Group = Get-ADGroup -Identity $Object.Trigger.Value
            if ($Group) {
                $Users = Get-ADGroupMember -Identity $Group
            }
        }
    }


    $CountUsers = Get-ObjectCount -Object $Users
    Write-Color -Text '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ', $Object.Trigger.Trigger, ' with value ', $Object.Trigger.Value -Color DarkGreen, White, DarkGreen, White, DarkGreen, White, DarkGreen, White, DarkGreen -StartSpaces 4
    foreach ($User in $Users) {
        $WriteSuccess = @{
            Text        = '[+] ', 'Execution ', $Name, ' on account ', $User.distinguishedName, ' done.'
            Color       = 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan'
            StartSpaces = 6
        }
        $WriteSkip = @{
            Text        = '[-] ', 'Execution ', $Name, ' on account ', $User.distinguishedName, ' skipped.'
            Color       = 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
            StartSpaces = 6
        }
        $WriteStatusSuccess = @{
            StartSpaces = 10
            Color       = 'Green', 'White', 'Green', 'White', 'Green'
        }
        $WriteStatusFail = @{
            StartSpaces = 10
            Color       = 'Red', 'White', 'Red', 'White', 'Red'
        }

        $Result = switch ( $Action ) {
            AccountAddGroupsSpecific {
                $CommandOutput = Add-ADUserGroups -User $User -Groups $ActionValue
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
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
                $CommandOutput = Remove-ADUserGroups -User $User -All
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsSecurity {
                $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Security
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsDistribution {
                $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Distribution
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsDomainLocal {
                $CommandOutput = Remove-ADUserGroups -User $User -GroupScope DomainLocal
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsGlobal {
                $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Global
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsUniversal {
                $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Universal
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRemoveGroupsSpecific {
                $CommandOutput = Remove-ADUserGroups -User $User -Groups $ActionValue
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
            AccountRename {
                $Status = Set-ADUserName -User $User -Option $ActionValue.Where -TextToAdd $ActionValue.Text
                if ($Status) { Write-Color @WriteSuccess } else { Write-Color @WriteSkip }
            }
            AccountSnapshot {
                $CommandOutput = Get-ADUserSnapshot -User $User -XmlPath $ActionValue
                if ($CommandOutput) {
                    Write-Color @WriteSuccess
                    foreach ($Output in $CommandOutput) {
                        if ($Output.Status) {
                            Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                        } else {
                            Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                        }
                    }
                } else {
                    Write-Color @WriteSkip
                }
            }
        }
    }
    return $Object
}