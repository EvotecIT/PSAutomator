function Submit-IgnoreMatchingFields {
    [CmdletBinding()]
    param(
        [Object] $Object,
        [Object] $Value
    )
    [string] $Field = $Value.Field
    [string] $Operator = $Value.Operator
    [Object] $Value = $Value.Value

    if ($Operator -eq 'notlike') {
        return $Object | Where-Object { $_."$Field" -notlike $Value }
    }
    if ($Operator -eq 'notcontains') {
        return $Object | Where-Object { $_."$Field" -notcontains $Value }
    }
    if ($Operator -eq 'ne') {
        return $Object | Where-Object { $_."$Field" -ne $Value }
    }
    if ($Operator -eq 'cnotlike') {
        return $Object | Where-Object { $_."$Field" -cnotlike $Value }
    }
    if ($Operator -eq 'cne') {
        return $Object | Where-Object { $_."$Field" -cne $Value }
    }
    if ($Operator -eq 'cnotcontains') {
        return $Object | Where-Object { $_."$Field" -cnotcontains $Value }
    }
}