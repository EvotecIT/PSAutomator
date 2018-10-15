Function Trigger {
    [CmdletBinding()]
    param (
        [string] $Name,
        [AutomatorTrigger] $Trigger,
        [string] $Value,
        $Configuration
    )
    Begin {

    }
    Process {
        #Write-Color $Script:Configuration.Prettify.CompanyName -Color Red
        Write-Color -Text 'Running Trigger', ' for ', $Name -Color White, White, Green -StartSpaces 2
        $Object = [ordered] @{}
        $Object.Trigger = @{
            Name    = $Name
            Trigger = $Trigger
            Value   = $Value
        }
    }
    End {
        return $Object
    }
}