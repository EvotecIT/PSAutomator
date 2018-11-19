function Submit-ConditionFields {
    [CmdletBinding()]
    param(
        [Object] $Object,
        [Object] $Value,
        [string] $Type = 'Default'
    )
    [string] $Field = ''
    if ($Type -eq 'Default') {
        $Field = "$($Value.Field)"
    } elseif ($Type -eq 'OrganizationalUnit') {

    } elseif ($Type -eq 'GroupMembership') {
        $Field = "MemberOf.$($Value.Field)"
        #Write-Color -Text 'test ', $Field -Color Red
    }



    [string] $Operator = $Value.Operator
    [Object] $Value = $Value.Value

        # Negative
        if ($Operator -eq 'notlike') {
            return $Object | Where-Object { $_.$Field -notlike $Value }
        }
        if ($Operator -eq 'notcontains') {
            return $Object | Where-Object { $_.$Field -notcontains $Value }
        }
        if ($Operator -eq 'ne') {
            return $Object | Where-Object { $_.$Field -ne $Value }
        }
        if ($Operator -eq 'cnotlike') {
            return $Object | Where-Object { $_.$Field -cnotlike $Value }
        }
        if ($Operator -eq 'cne') {
            return $Object | Where-Object { $_.$Field -cne $Value }
        }
        if ($Operator -eq 'cnotcontains') {
            return $Object | Where-Object { $_.$Field -cnotcontains $Value }
        }

        # Positive
        if ($Operator -eq 'like') {
            return $Object | Where-Object { $_.$Field -like $Value }
        }
        if ($Operator -eq 'contains') {
            return $Object | Where-Object { $_.$Field -contains $Value }
        }
        if ($Operator -eq 'eq') {
            return $Object | Where-Object { $_.$Field -eq $Value }
        }
        if ($Operator -eq 'clike') {
            return $Object | Where-Object { $_.$Field -clike $Value }
        }
        if ($Operator -eq 'ceq') {
            return $Object | Where-Object { $_.$Field -ceq $Value }
        }
        if ($Operator -eq 'ccontains') {
            return $Object | Where-Object { $_.$Field -ccontains $Value }
        }

}