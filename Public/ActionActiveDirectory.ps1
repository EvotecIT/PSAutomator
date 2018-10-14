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
        $Result = switch ( $Action ) {
            AccountAddGroupsSpecific {
                $CommandOutput = Add-ADUserGroups -User $User -Groups $ActionValue
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
                $CommandOutput = Set-ADUserName -User $User -Option $ActionValue.Where -TextToAdd $ActionValue.Text
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
            }
            AccountSnapshot {
                $CommandOutput = Get-ADUserSnapshot -User $User -XmlPath $ActionValue
                Out-ActionStatus -CommandOutput $CommandOutput -User $User -Name $Name
            }
        }
    }
    return $Object
}