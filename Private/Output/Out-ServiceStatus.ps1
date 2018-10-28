function Out-ServiceStatus {
    param(
        [string] $Name
    )
    $WriteInformation = @{
        Text        = '[i]', ' Running ', 'Service', ' for ', $Name
        Color       = [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::Green, [ConsoleColor]::White, [ConsoleColor]::White, [ConsoleColor]::Green
        StartSpaces = 0
    }
    Write-Color @WriteInformation
}