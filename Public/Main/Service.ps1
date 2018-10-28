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
        Out-ServiceStatus -Name $Name
        Get-PSAutomatorConfiguration -ConfigurationPath $ConfigurationPath

        $Object = Invoke-Command -ScriptBlock $ServiceData
        $Final = Complete-WorkFlow -Object $Object
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
        return #$Final
    }
}