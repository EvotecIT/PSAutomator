function Ignore {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [PSAutomator.Ignore] $Ignore,
        [Object] $Value
    )
    Begin {}
    Process {
        if ($Object -eq $null) {
            Write-Warning "Ignore can't be used out of order. Terminating!"
            Exit
        }
        $Object.Ignores += @{
            Name   = if ($Name -eq '') { 'No name given' } else { $Name }
            Ignore = $Ignore
            Value  = $Value
        }
    }
    End {
        return $Object
    }
}