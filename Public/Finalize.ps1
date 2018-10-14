Function Finalize {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $false, Position = 0)] $Object
    )
    return $Object
}