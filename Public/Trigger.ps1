Function Trigger {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [PSAutomator.Trigger] $Trigger,
        [Object] $Value
    )
    Begin {

    }
    Process {
        if ($Object -eq $null) {
            # if object is null it's the first one
            $Object = [ordered] @{
                Triggers       = @()
                Conditions     = @()
                Ignores        = @()
                Actions        = @()
                ProcessingData = @{
                    Users = @()
                }
            }
        }
        $Object.Triggers += @{
            Name    = $Name
            Trigger = $Trigger
            Value   = $Value
        }
    }
    End {
        return $Object
    }
}