Function ActionActiveDirectory {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [PSAutomator.ActionAD] $Action,
        [Object] $Value
    )
    Begin {}
    Process {
        if ($Object -eq $null) {
            Write-Warning "Action can't be used out of order. Terminating!"
            Exit
        }
        $Object.Actions += @{
            Name   = $Name
            Action = $Action
            Value  = $Value
        }
    }
    End {
        return $Object
    }
}