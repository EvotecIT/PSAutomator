Function Service {
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
        if ($Status -eq 'Disable') {
            return
        }
        if (($ConfigurationPath) -and (Test-Path $ConfigurationPath)) {
            $Script:Configuration = Import-Clixml -Path $ConfigurationPath
        }
        Write-Color -Text 'Running Service', ' for ', $Name -Color White, White, Green
        $Final = Invoke-Command -ScriptBlock $ServiceData
    }
    End {
        $TimeEnd = $TimeRun | Stop-TimeLog -Option 'Array'
        Write-Color -Text 'Ending Service for ', $Name, ' - Time to Execute: ', $TimeEnd -Color White, Green, White, Green -LinesAfter 1
        $Script:Configuration = $null
        #$Final | ConvertTo-Json
        return
    }
}