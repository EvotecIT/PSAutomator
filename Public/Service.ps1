Function Service {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)][string] $Name,
        [string] $Status,
        [Alias('Tags')][string[]] $Tag = @(),
        [string] $ConfigurationPath,
        [Parameter(Position = 1)][ValidateNotNull()][ScriptBlock] $ServiceData = $(Throw "No test script block is provided. (Have you put the open curly brace on the next line?)")
    )
    Begin {
        $TimeRun = Start-TimeLog
    }
    Process {
        if ($Status -eq 'Disable') { return }
        $WriteInformation = @{
            Text        = '[i]', ' Running Service', ' for ', $Name
            Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::Green
            StartSpaces = 0
        }
        Write-Color @WriteInformation
        Get-PSAutomatorConfiguration -ConfigurationPath $ConfigurationPath

        $Final = Invoke-Command -ScriptBlock $ServiceData
    }
    End {
        $TimeEnd = $TimeRun | Stop-TimeLog -Option 'Array'

        $WriteInformation = @{
            Text        = '[i]', ' Ending Service for ', $Name, ' - Time to Execute: ', $TimeEnd
            Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::Green, [ConsoleColor]::Green, [ConsoleColor]::White
            LinesAfter  = 1
            StartSpaces = 0
        }
        Write-Color @WriteInformation

        # Finish Service
        $Script:Configuration = $null
        return
    }
}