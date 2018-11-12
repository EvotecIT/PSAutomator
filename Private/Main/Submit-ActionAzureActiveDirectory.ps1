function Submit-ActionAzureActiveDirectory {
    [CmdletBinding()]
    param(
        $Object,
        $Action
    )
    foreach ($User in $Object.ProcessingData.Users) {
        switch ( $Action.Action ) {

            AccountDisable {
                $CommandOutput = Set-WinAzureADUserStatus -User $User -Option Disable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
            AccountEnable {
                $CommandOutput = Set-WinAzureADUserStatus -User $User -Option Enable -WhatIf:$Action.WhatIf
                Out-ActionStatus -CommandOutput $CommandOutput -UserAzureAD $User -Name $Action.Name -WhatIf:$Action.WhatIf
            }
        }
    }
}