function Out-TriggerStatus {
    param(
        $Trigger
    )
    $WriteInformation = @{
        Text        = '[+]', ' Running Trigger', ' for ', $Trigger.Name
        Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::White, [ConsoleColor]::Green
        StartSpaces = 4
    }
    Write-Color @WriteInformation
}