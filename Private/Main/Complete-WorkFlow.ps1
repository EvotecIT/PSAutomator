Function Complete-WorkFlow {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object
    )
    Begin {

    }
    Process {
        if ($null -eq $Object) {
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
            if ($Trigger.Type -eq 'UserAzureAD') {
                switch ($Trigger.Trigger) {
                    All {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -All
                    }
                    ByFields {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -Trigger $Trigger.Value
                    }
                    Deleted {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -ReturnDeletedUsers
                    }
                    Domain {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -Trigger $Trigger.Value
                    }
                    Synchronized {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -Synchronized
                    }
                    Unlicensed {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -ReturnUnlicensedUsers
                    }
                    UserPrincipalName {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -UserPrincipalName $Trigger.Value
                    }
                    Search {
                        $Object.ProcessingData.Users += Get-WinAzureADUsers -Trigger $Trigger.Value
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
                    $Object.ProcessingData.Users = $Object.ProcessingData.Users | Where-Object { $null -ne $_.$Field -and $_.$Field -ne '' }
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
                Submit-ActiveDirectory -Object $Object -Action $Action
            }
            if ($Action.Type -eq 'AzureActiveDirectory') {
                Submit-AzureActiveDirectory -Object $Object -Action $Action
            }
        }
    }
    End {
        return $Object
    }
}