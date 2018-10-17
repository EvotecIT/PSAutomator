function Get-PSAutomatorConfiguration {
    [CmdletBinding()]
    param(
        $ConfigurationPath
    )
    if (($ConfigurationPath) -and (Test-Path $ConfigurationPath)) {
        $Script:Configuration = Import-Clixml -Path $ConfigurationPath
    }
}