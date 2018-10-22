function Search-ObjectToIgnore {
    [CmdletBinding()]
    param(
        $Object,
        $Ignore
    )
    #Write-Color @Script:WriteParameters -Text '[i]', ' Processing object ', $Object.DisplayName, ' for ignore list candidate' -Color Yellow, White, Red
    foreach ($Key in $Ignore.Keys) {
        if ($Key -eq 'MatchingEmptyOrNull') {
            foreach ($SubKey in $Ignore.$Key.Keys) {
                $FieldType = $SubKey
                $IgnoreValues = $Ignore.$Key.$SubKey
                foreach ($Value in $IgnoreValues) {
                    if ($FieldType -and $Value) {
                        if ([String]::IsNullOrWhiteSpace($Object.$FieldType)) {
                            Write-Color @Script:WriteParameters -Text '[i]', ' Adding object ', $Object.DisplayName, ' to Ignore List because field: ', $FieldType, ' is null or empty.' -Color Yellow, White, Red, White, Green, White, Yellow, White
                            return
                        }
                    }
                }
            }
        }
        if ($Key -eq 'MatchingObjects') {
            foreach ($SubKey in $Ignore.$Key.Keys) {
                $FieldType = $SubKey
                $IgnoreValues = $Ignore.$Key.$SubKey
                foreach ($Value in $IgnoreValues) {
                    if ($FieldType -and $Value) {
                        if ($FieldType -eq 'Mailbox') {
                            if ($Object.$Value) {
                                # for example $Contact.WindowsEmailAddress
                                $User = Get-User $($Object.$Value) -ErrorAction SilentlyContinue
                                if ($User) {
                                    Write-Color @Script:WriteParameters -Text '[i]', ' Adding object ', $Object.DisplayName, ' to Ignore List because Exchange Mailbox ', $User.DisplayName, ' already exists.' -Color Yellow, White, Red, White, Green, White, Yellow, White
                                    return
                                }
                            }
                        } elseif ($FieldType -eq 'ADUser') {
                            if ($Object.$Value) {
                                # for example $Contact.WindowsEmailAddress
                                $User = Get-ADUser $($Object.$Value) -ErrorAction SilentlyContinue
                                if ($User) {
                                    Write-Color @Script:WriteParameters -Text '[i]', ' Adding object ', $Object.DisplayName, ' to Ignore List because AD User ', $User.DisplayName, ' already exists.' -Color Yellow, White, Red, White, Green, White, Yellow, White
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        if ($Key -eq 'MatchingFields') {
            foreach ($SubKey in $Ignore.$Key.Keys) {
                $FieldType = $SubKey
                $IgnoreValues = $Ignore.$Key.$SubKey
                foreach ($Value in $IgnoreValues) {
                    if ($FieldType -and $Value) {
                        if ($Object.$FieldType -like $Value) {
                            Write-Color @Script:WriteParameters -Text '[i]', ' Adding object ', $Object.DisplayName, ' to Ignore List because field: ', $FieldType, ' with Value: ', $Value, ' matched.' -Color Yellow, White, Red, White, Green, White, Yellow, White
                            return
                        }
                    }
                }
            }
        }
    }
    return $Object
}