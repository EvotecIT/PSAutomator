function Out-ConfigurationStatus {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)][Array] $CommandOutput,
        [string] $Option = 'Start'
    )

    $WriteStatusSuccess = @{
        StartSpaces = 4
        Color       = 'Green', 'White', 'Green', 'White', 'Green', 'White', 'Green'
    }
    $WriteStatusEnd = @{
        StartSpaces = 4
        Color       = 'Green', 'White', 'Green', 'White', 'Green', 'White', 'Green'
    }
    $WriteStatusFail = @{
        StartSpaces = 4
        Color       = 'Red', 'White', 'Red', 'White', 'Red', 'White', 'Red'
    }
    if ($Option -eq 'Start') {
        Write-Color @WriteStatusSuccess -Text '[+] ', 'Running ', 'Configuration'
    } elseif ($Option -eq 'End') {
        Write-Color @WriteStatusEnd -Text '[+] ', 'Running ', 'Configuration'
    } else {
        Write-Color @WriteStatusFail -Text '[-] ', 'Ending ', 'Configuration'
    }
}