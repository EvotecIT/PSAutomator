function Submit-ActionAzureActiveDirectory {
    [CmdletBinding()]
    param(
        $Object,
        $Action
    )
    foreach ($User in $Object.ProcessingData.Users) {
        switch ( $Action.Action ) {
            AccountAddGroupsSpecific {

            }
            AccountDisable {
                $CommandOutput = Set-WinAzureADUserStatus -User $User -Option Disable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountEnable {
                $CommandOutput = Set-WinAzureADUserStatus -User $User -Option Enable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountRemoveGroupsAll {

            }
            AccountRemoveGroupsSecurity {

            }
            AccountRemoveGroupsDistribution {

            }
            AccountRemoveGroupsSpecific  {

            }
            AccountRename {

            }
            AccountSnapshot {

            }
            AddLicense {
                $CommandOutput = Set-WinAzureADUserLicense -User $User -Option Add -License $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            RemoveLicense {
                $CommandOutput = Set-WinAzureADUserLicense -User $User -Option Remove -License $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            RemoveLicenseAll {
                $CommandOutput = Set-WinAzureADUserLicense -User $User -Option RemoveAll -License '' -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            ReplaceLicense {
                $CommandOutput = Set-WinAzureADUserLicense -User $User -Option Replace -License $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            EnableMFA {

            }
            DisableMFA {

            }
            SetUserRole {

            }
            SetField {
                $CommandOutput = Set-WinAzureADUserField -User $User -Value $Action.Value -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            SynchronizeFields {

            }

        }
    }
}