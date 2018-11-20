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
        $Field = "$($Value.Field)"
    } elseif ($Type -eq 'GroupMembership') {
        $Field = "$($Value.Field)"
    }

    [string] $Operator = $Value.Operator
    [Object] $Value = $Value.Value

    # Negative
    if ($Operator -eq 'notlike') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -notlike $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -notlike $Value }
        } else {
            return $Object | Where-Object { $_.$Field -notlike $Value }
        }
    }
    if ($Operator -eq 'notcontains') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -notcontains $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -notcontains $Value }
        } else {
            return $Object | Where-Object { $_.$Field -notcontains $Value }
        }
    }
    if ($Operator -eq 'ne') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -ne $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -ne $Value }
        } else {
            return $Object | Where-Object { $_.$Field -ne $Value }
        }
    }
    if ($Operator -eq 'cnotlike') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -cnotlike $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -cnotlike $Value }
        } else {
            return $Object | Where-Object { $_.$Field -cnotlike $Value }
        }
    }
    if ($Operator -eq 'cne') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -cne $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -cne $Value }
        } else {
            return $Object | Where-Object { $_.$Field -cne $Value }
        }
    }
    if ($Operator -eq 'cnotcontains') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -cnotcontains $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -cnotcontains $Value }
        } else {
            return $Object | Where-Object { $_.$Field -cnotcontains $Value }
        }
    }

    # Positive
    if ($Operator -eq 'like') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -like $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -like $Value }
        } else {
            return $Object | Where-Object { $_.$Field -like $Value }
        }
    }
    if ($Operator -eq 'contains') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -contains $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -contains $Value }
        } else {
            return $Object | Where-Object { $_.$Field -contains $Value }
        }
    }
    if ($Operator -eq 'eq') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -eq $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -eq $Value }
        } else {
            return $Object | Where-Object { $_.$Field -eq $Value }
        }
    }
    if ($Operator -eq 'clike') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -clike $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -clike $Value }
        } else {
            return $Object | Where-Object { $_.$Field -clike $Value }
        }
    }
    if ($Operator -eq 'ceq') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -ceq $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -ceq $Value }
        } else {
            return $Object | Where-Object { $_.$Field -ceq $Value }
        }
    }
    if ($Operator -eq 'ccontains') {
        if ($Type -eq 'OrganizationalUnit') {
            return $Object | Where-Object { $_.OrganizationalUnit.$Field -ccontains $Value }
        } elseif ($Type -eq 'GroupMembership') {
            return $Object | Where-Object { $_.MemberOf.$Field -ccontains $Value }
        } else {
            return $Object | Where-Object { $_.$Field -ccontains $Value }
        }
    }


}