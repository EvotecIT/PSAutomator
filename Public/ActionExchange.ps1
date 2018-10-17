Function ActionExchange {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [PSAutomator.ActionExchange] $Action,
        [Object] $ActionValue
    )
    $Trigger = switch ($Object.Trigger.Trigger) {
        OrganizationalUnit {
            $Users = Get-ActiveDirectoryUsersByOU -OrganizationalUnit $Object.Trigger.Value
        }
    }
    $CountUsers = Get-ObjectCount -Object $Users

    $WriteInformation = @{
        Text        = '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ', $Object.Trigger.Trigger, ' with value ', $Object.Trigger.Value
        Color       = [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, `
            [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen, [ConsoleColor]::White, [ConsoleColor]::DarkGreen
        StartSpaces = 4
    }
    Write-Color @WriteInformation

    foreach ($User in $Users) {
        #$Result = switch ( $Action ) {

        #}
    }
    return $Object
}