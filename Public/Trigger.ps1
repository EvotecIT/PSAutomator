Function Trigger {
    [CmdletBinding()]
    param (
        [string] $Name,
        [AutomatorTrigger] $Trigger,
        [string] $Value
    )
    Write-Color -Text 'Running Trigger', ' for ', $Name -Color White, White, Green -StartSpaces 1
    $Object = [ordered] @{}
    $Object.Trigger = @{
        Name    = $Name
        Trigger = $Trigger
        Value   = $Value
    }
    if ($Trigger -eq 'OU' -or 'OrganizationalUnit') {
        return $Object
    } elseif ($Trigger -eq 'GroupMembership') {
        return $Object
    }
    return
}