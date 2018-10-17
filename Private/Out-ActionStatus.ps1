function Out-ActionStatus {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)][Array] $CommandOutput,
        [parameter(Mandatory = $true)][Microsoft.ActiveDirectory.Management.ADAccount] $User,
        [parameter(Mandatory = $true)][string] $Name
    )
    $WriteSuccess = @{
        Text        = '[+] ', 'Execution ', $Name, ' on account ', $User.distinguishedName, ' done.'
        Color       = 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan', 'White', 'Cyan'
        StartSpaces = 8
    }
    $WriteSkip = @{
        Text        = '[-] ', 'Execution ', $Name, ' on account ', $User.distinguishedName, ' skipped.'
        Color       = 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow', 'White', 'Yellow'
        StartSpaces = 8
    }
    $WriteStatusSuccess = @{
        StartSpaces = 12
        Color       = 'Green', 'White', 'Green', 'White', 'Green'
    }
    $WriteStatusFail = @{
        StartSpaces = 12
        Color       = 'Red', 'White', 'Red', 'White', 'Red'
    }
    if ($CommandOutput) {
        Write-Color @WriteSuccess
        foreach ($Output in $CommandOutput) {
            if ($Output.Status) {
                Write-Color @WriteStatusSuccess -Text '[+] ', 'Successfully processed ', $Output.Output, ' Extended information: ', $Output.Extended
            } else {
                Write-Color @WriteStatusFail -Text '[-] ', 'Skipped ', $Output.Output, ' Extended information: ', $Output.Extended
            }
        }
    } else {
        Write-Color @WriteSkip
    }
}