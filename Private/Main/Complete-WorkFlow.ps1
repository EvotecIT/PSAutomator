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
                Text        = '[+] ', 'Action ', $Action.Name, ' on ', $CountUsers, ' objects based on trigger ' #, $Trigger.Trigger, ' with value ', $Trigger.Value
                Color       = [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, `
                    [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen
                StartSpaces = 4
            }
            Write-Color @WriteInformation

            if ($Action.Type -eq 'ActiveDirectory') {

                foreach ($User in $Object.ProcessingData.Users) {
                    $Result = switch ( $Action.Action ) {
                        AccountAddGroupsSpecific {
                            $CommandOutput = Add-ADUserGroups -User $User -Groups $Action.Value -FieldSearch 'Name'
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountDisable {
                            $CommandOutput = Set-ADUserStatus -User $User -Option Disable
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountEnable {
                            $CommandOutput = Set-ADUserStatus -User $User -Option Enable
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountHideInGAL {
                            $CommandOutput = Set-ADUserSettingGAL -User $User -Option Hide
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountShowInGAL {
                            $CommandOutput = Set-ADUserSettingGAL -User $User -Option Show
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsAll {
                            $CommandOutput = Remove-ADUserGroups -User $User -All
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsSecurity {
                            $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Security
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsDistribution {
                            $CommandOutput = Remove-ADUserGroups -User $User -GroupCategory Distribution
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsDomainLocal {
                            $CommandOutput = Remove-ADUserGroups -User $User -GroupScope DomainLocal
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsGlobal {
                            $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Global
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsUniversal {
                            $CommandOutput = Remove-ADUserGroups -User $User -GroupScope Universal
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRemoveGroupsSpecific {
                            $CommandOutput = Remove-ADUserGroups -User $User -Groups $ActionValue
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountRename {
                            $CommandOutput = Set-ADUserName -User $User -Option $Action.Value.Where -TextToAdd $Action.Value.Text
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
                        }
                        AccountSnapshot {
                            $CommandOutput = Get-ADUserSnapshot -User $User -XmlPath $Action.Value
                            Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Action.Name
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