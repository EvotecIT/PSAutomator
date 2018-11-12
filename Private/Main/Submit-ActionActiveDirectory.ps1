function Submit-ActionActiveDirectory {
    [CmdletBinding()]
    param(
        $Object,
        $Action
    )
    foreach ($User in $Object.ProcessingData.Users) {
        switch ( $Action.Action ) {
            AccountAddGroupsSpecific {
                $CommandOutput = Add-WinADUserGroups -User $User -Groups $Action.Value -FieldSearch 'Name' -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountDisable {
                $CommandOutput = Set-WinADUserStatus -User $User -Option Disable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountEnable {
                $CommandOutput = Set-WinADUserStatus -User $User -Option Enable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountHideInGAL {
                $CommandOutput = Set-WinADUserSettingGAL -User $User -Option Hide -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountShowInGAL {
                $CommandOutput = Set-WinADUserSettingGAL -User $User -Option Show -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsAll {
                $CommandOutput = Remove-WinADUserGroups -User $User -All -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsSecurity {
                $CommandOutput = Remove-WinADUserGroups -User $User -GroupCategory Security -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsDistribution {
                $CommandOutput = Remove-WinADUserGroups -User $User -GroupCategory Distribution -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsDomainLocal {
                $CommandOutput = Remove-WinADUserGroups -User $User -GroupScope DomainLocal -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsGlobal {
                $CommandOutput = Remove-WinADUserGroups -User $User -GroupScope Global -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsUniversal {
                $CommandOutput = Remove-WinADUserGroups -User $User -GroupScope Universal -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsSpecific {
                $CommandOutput = Remove-WinADUserGroups -User $User -Groups $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRename {
                if ($Action.Value.Action -eq 'AddText') {
                    $CommandOutput = Set-WinADUserFields -User $User -Option $Action.Value.Where -TextToAdd $Action.Value.Text -Fields $Action.Value.Fields -WhatIf:$Action.WhatIf
                    Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
                } elseif ($Action.Value.Action -eq 'RemoveText') {
                    $CommandOutput = Set-WinADUserFields -User $User -TextToRemove $Action.Value.Text -Fields $Action.Value.Fields -WhatIf:$Action.WhatIf
                    Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
                }
            }
            AccountSnapshot {
                $CommandOutput = Get-WinADUserSnapshot -User $User -XmlPath $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
        }
    }

}