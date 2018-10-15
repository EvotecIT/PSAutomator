function New-PSAutomatorConfiguration {
    param(
        [Object] $Configuration,
        $Path
    )
    if ($Configuration) {
        $Configuration | Export-Clixml -Path $Path
    }
}