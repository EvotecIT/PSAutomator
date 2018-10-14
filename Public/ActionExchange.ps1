Function ActionExchange {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [AutomatorAction] $Action,
        [Object] $ActionValue
    )
    $Trigger = switch ($Object.Trigger.Trigger) {
        OrganizationalUnit {
            $Users = Get-ActiveDirectoryUsersByOU -OrganizationalUnit $Object.Trigger.Value
        }
    }
    $CountUsers = Get-ObjectCount -Object $Users
    Write-Color -Text '[+] ', 'Action ', $Name, ' on ', $CountUsers, ' objects based on trigger ', $Object.Trigger.Trigger, ' with value ', $Object.Trigger.Value -Color Green, White, Green, White, Green, White, Green, White, Green -StartSpaces 2
    foreach ($User in $Users) {
        #$Result = switch ( $Action ) {

        #}
    }
    return $Object
}