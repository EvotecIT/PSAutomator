function Out-ConnectionStatus {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)][Array] $CommandOutput
    )

    $WriteStatusSuccess = @{
        StartSpaces = 8
        Color       = 'Green', 'White', 'Green', 'White', 'Green', 'White', 'Green'
    }
    $WriteStatusFail = @{
        StartSpaces = 8
        Color       = 'Red', 'White', 'Red', 'White', 'Red', 'White', 'Red'
    }
    if ($CommandOutput) {
        foreach ($Output in $CommandOutput) {
            if ($Output.Status) {
                Write-Color @WriteStatusSuccess -Text '[+] ', 'Running ', 'Connection', ' for ', $Output.Output, ' Extended information: ', $Output.Extended
            } else {
                Write-Color @WriteStatusFail -Text '[-] ', 'Running ', 'Connection', ' for ', $Output.Output, ' Extended information: ', $Output.Extended
            }
        }
    }
}