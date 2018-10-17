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

        foreach ($Trigger in $Object.Triggers) {
            $WriteInformation = @{
                Text        = '[+]', ' Running Trigger', ' for ', $Trigger.Name
                Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::White, [ConsoleColor]::Green
                StartSpaces = 4
            }
            Write-Color @WriteInformation

            switch ($Trigger.Trigger) {
                OrganizationalUnit {
                    $Object.ProcessingData.Users += Get-ActiveDirectoryUsersByOU -OrganizationalUnit $Trigger.Value
                }
                GroupMembership {
                    $Group = Get-ADGroup -Identity $Trigger.Value
                    if ($Group) {
                        $Object.ProcessingData.Users += Get-ADGroupMember -Identity $Group
                    }
                }
            }
        }


        $CountUsers = Get-ObjectCount -Object $Object.ProcessingData.Users

        foreach ($Action in $Object.Actions) {



            $WriteInformation = @{
                Text        = '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ' #, $Trigger.Trigger, ' with value ', $Trigger.Value
                Color       = [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, `
                    [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen
                StartSpaces = 4
            }
            Write-Color @WriteInformation

            foreach ($User in $Object.ProcessingData.Users) {
                $Result = switch ( $Action.Action ) {
                    AccountAddGroupsSpecific {
                        $CommandOutput = Add-ADUserGroups -User $User -Groups $Action.Value
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountDisable {
                        $CommandOutput = Set-ADUserStatus -User $User -Option Disable
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountEnable {
                        $CommandOutput = Set-ADUserStatus -User $User -Option Enable
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountHideInGAL {
                        $CommandOutput = Set-ADUserSettingGAL -User $User -Option Hide
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountShowInGAL {
                        $CommandOutput = Set-ADUserSettingGAL -User $User -Option Show
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsAll {
                        $CommandOutput = Remove-ADUserGroups -User $User -All
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsSecurity {
                        $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Security
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsDistribution {
                        $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Distribution
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsDomainLocal {
                        $CommandOutput = Remove-ADUserGroups -User $User -GroupScope DomainLocal
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsGlobal {
                        $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Global
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsUniversal {
                        $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Universal
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRemoveGroupsSpecific {
                        $CommandOutput = Remove-ADUserGroups -User $User -Groups $ActionValue
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountRename {
                        $CommandOutput = Set-ADUserName -User $User -Option $Action.Value.Where -TextToAdd $Action.Value.Text
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                    AccountSnapshot {
                        $CommandOutput = Get-ADUserSnapshot -User $User -XmlPath $Action.Value
                        Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
                    }
                }
            }
        }
    }
    End {
        return $Object
    }
}