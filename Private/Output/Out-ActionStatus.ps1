function Out-ActionStatus {
    [CmdletBinding(DefaultParameterSetName = 'ActiveDirectory')]
    param(
        [parameter(Mandatory = $false)][Array] $CommandOutput,
        [parameter(Mandatory = $true, ParameterSetName = "ActiveDirectory")][Microsoft.ActiveDirectory.Management.ADAccount] $User,
        [parameter(Mandatory = $true, ParameterSetName = "AzureActiveDirectory")][Microsoft.Online.Administration.User] $UserAzureAD,
        [parameter(Mandatory = $true)][string] $Name,
        [switch] $WhatIf
    )
    switch ($PSCmdlet.ParameterSetName) {
        ActiveDirectory {
            $UserInformation = $User.DistinguishedName
        }
        AzureActiveDirectory {
            $UserInformation = $UserAzureAD.UserPrincipalName
        }
    }
    if ($WhatIf) {
        $WriteSuccess = @{
            Text        = '[+] ', 'WhatIf: ', 'Execution ', $Name, ' on account ', $UserInformation, ' done.'
            Color       = [System.ConsoleColor]::Cyan, [System.ConsoleColor]::DarkMagenta, [System.ConsoleColor]::White, [System.ConsoleColor]::Cyan,
            [System.ConsoleColor]::White, [System.ConsoleColor]::Cyan, [System.ConsoleColor]::White, [System.ConsoleColor]::Cyan,
            [System.ConsoleColor]::White, [System.ConsoleColor]::Cyan
            StartSpaces = 8
        }
        $WriteSkip = @{
            Text        = '[+] ', 'WhatIf: ', 'Execution ', $Name, ' on account ', $UserInformation, ' done.'
            Color       = 'Yellow', [System.ConsoleColor]::DarkMagenta, 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
            StartSpaces = 8
        }

        $WriteStatusSuccess = @{
            StartSpaces = 12
            Color       = 'Green', [System.ConsoleColor]::DarkMagenta, 'White', 'Green', 'White', 'Green'
        }
        $WriteStatusFail = @{
            StartSpaces = 12
            Color       = 'Red', [System.ConsoleColor]::DarkMagenta, 'White', 'Red', 'White', 'Red'
        }

    } else {
        $WriteSuccess = @{
            Text        = '[+] ', 'Execution ', $Name, ' on account ', $UserInformation, ' done.'
            Color       = 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan'
            StartSpaces = 8
        }
        $WriteSkip = @{
            Text        = '[+] ', 'Execution ', $Name, ' on account ', $UserInformation, ' done.'
            Color       = 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
            StartSpaces = 8
        }

        $WriteStatusSuccess = @{
            StartSpaces = 12
            Color       = 'Green', 'White', 'Green', 'White', 'Green'
        }
        $WriteStatusFail = @{
            StartSpaces = 12
            Color       = 'Red', 'White', 'Red', 'White', 'Red'
        }
    }

    if ($CommandOutput) {
        Write-Color @WriteSuccess
        foreach ($Output in $CommandOutput) {
            if ($Output.Status) {
                if ($WhatIf) {
                    Write-Color @WriteStatusSuccess -Text '[+] ', 'WhatIf: ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                } else {
                    Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
                }
            } else {
                if ($WhatIf) {
                    Write-Color @WriteStatusFail -Text '[-] ', 'Whatif: ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                } else {
                    Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
                }
            }
        }
    } else {
        Write-Color @WriteSkip
    }
}