Function Complete-WorkFlow {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object
    )
    Begin {

    }
    Process {
        if ($Object -eq $null) {
            Write-Warning "Complete-WorkFlow can't be used out of order. Terminating!"
            Exit
        }
        Start-Configuration -Configuration $Script:Configuration

        foreach ($Trigger in $Object.Triggers) {
            Out-TriggerStatus -Trigger $Trigger

            if ($Trigger.Type -eq 'User') {
                switch ($Trigger.Trigger) {
                    Always {
                        $Object.ProcessingData.Users += Get-WinADUsers -Filter '*'
                    }
                    Filter {
                        $Object.ProcessingData.Users += Get-WinADUsers -Filter $Trigger.Value
                    }
                    GroupMembership {
                        $Object.ProcessingData.Users += Get-WinADUsers -Group $Trigger.Value
                    }
                    OrganizationalUnit {
                        $Object.ProcessingData.Users += Get-WinADUsers -OrganizationalUnit $Trigger.Value
                    }
                }
            }
        }

        foreach ($Ignore in $Object.Ignores) {
            $WriteInformation = @{
                Text        = '[+]', ' Running Ignore', ' for ', $Ignore.Name
                Color       = [ConsoleColor]::Magenta, [ConsoleColor]::White, [ConsoleColor]::White, [ConsoleColor]::Magenta
                StartSpaces = 4
            }
            Write-Color @WriteInformation
            switch ($Ignore.Ignore) {
                MatchingEmptyOrNull {
                    $Field = "$($Ignore.Value)"
                    $Object.ProcessingData.Users = $Object.ProcessingData.Users | Where { $_.$Field -ne $null -and $_.$Field -ne '' }
                }
            }

        }


        $CountUsers = Get-ObjectCount -Object $Object.ProcessingData.Users

        foreach ($Action in $Object.Actions) {

            $WriteInformation = @{
                Color       = [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, `
                    [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen
                StartSpaces = 4
            }
            if ($Action.WhatIf) {
                $WriteInformation.Text = '[+] ', 'Action ', $Action.Name, ' on ', $CountUsers, ' objects based on trigger (pretending only!)' #, $Trigger.Trigger, ' with value ', $Trigger.Value
            } else {
                $WriteInformation.Text = '[*] ', 'Action ', $Action.Name, ' on ', $CountUsers, ' objects based on trigger' #, $Trigger.Trigger, ' with value ', $Trigger.Value
            }
            Write-Color @WriteInformation

            if ($Action.Type -eq 'ActiveDirectory') {

                foreach ($User in $Object.ProcessingData.Users) {
                    $Result = switch ( $Action.Action ) {
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
        }
    }
    End {
        return $Object
    }
}