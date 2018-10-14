function Condition {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object,
        [string] $Name
    )
    $Object.Condition = @{
        Name = $Name
    }
    return $Object
}