Function Trigger {
    [CmdletBinding()]
    param (
        [string] $Name,
        [PSAutomator.Trigger] $Trigger,
        [string] $Value,
        $Configuration
    )
    Begin {
        $WriteInformation = @{
            Text        = '[+]', ' Running Trigger', ' for ', $Name
            Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::White, [ConsoleColor]::Green
            StartSpaces = 4
        }
        Write-Color @WriteInformation
    }
    Process {
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