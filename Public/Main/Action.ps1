Function Action {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)] $Object,
        [parameter(Mandatory = $false)] [string] $Name,
        [parameter(Mandatory = $false, ParameterSetName = "ActiveDirectory")][PSAutomator.ActionAD] $ActiveDirectory,
        [parameter(Mandatory = $false, ParameterSetName = "AzureActiveDirectory")][PSAutomator.ActionAzureAD] $AzureActiveDirectory,
        [parameter(Mandatory = $false, ParameterSetName = "Exchange")][PSAutomator.ActionExchange] $Exchange,
        [parameter(Mandatory = $false)] [Object] $Value,
        [parameter(Mandatory = $false)] [switch] $WhatIf
    )
    Begin {}
    Process {
        if ($Object -eq $null) {
            Write-Warning "Action can't be used out of order. Terminating!"
            Exit
        }
        $Action = @{
            Name   = $Name
            Value  = $Value
            Type   = $PSCmdlet.ParameterSetName
            WhatIf = $WhatIf
        }
        switch ($PSCmdlet.ParameterSetName) {
            ActiveDirectory {
                $Action.Action = $ActiveDirectory
            }
            AzureActiveDirectory {
                $Action.Action = $AzureActiveDirectory
            }
            Exchange {
                $Action.Action = $Exchange
            }
        }

        # Add prepared data to Object
        $Object.Actions += $Action
    }
    End {
        return $Object
    }
}