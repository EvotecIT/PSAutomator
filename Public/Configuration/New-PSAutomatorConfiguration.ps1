function New-PSAutomatorConfiguration {
    [CmdletBinding()]
    param(
        [Object] $Configuration,
        $Path
    )
    if ($Configuration) {
        $Configuration | Export-Clixml -Path $Path -Encoding UTF8
    }
}