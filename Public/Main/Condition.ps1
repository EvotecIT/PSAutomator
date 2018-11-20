function Condition {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [PSAutomator.Condition] $Condition,
        [Object] $Value
    )
    Begin {}
    Process {
        if ($Object -eq $null) {
            Write-Warning "Condition can't be used out of order. Terminating!"
            Exit
        }
        $Object.Conditions += @{
            Name      = if ($Name -eq '') { 'No name given' } else { $Name }
            Condition = $Condition
            Value     = $Value
        }
    }
    End {
        return $Object
    }
}