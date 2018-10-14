function Ignore {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name,
        [AutomatorIgnore] $IgnoreAction,
        $IgnoreParameter,
        $IgnoreValue
    )
    $Object.Ignore = @{
        Name            = $Name
        IgnoreAction    = $IgnoreAction
        IgnoreParameter = $IgnoreParameter
        IgnoreValue     = $IgnoreValue
    }

    #Write-Color -Text 'Trigger: ', $Object.Trigger -Color Yellow

    #Write-Color -Text "Ignoring ", $Object, ' ', $Name -Color White, Red
    return $Object
}