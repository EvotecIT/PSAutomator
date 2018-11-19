function Submit-ConditionEmptyOrNull {
    param(
        [Object] $Object,
        [Object] $Value
    )
    $Field = "$Value"
    $ObjectOutput = $Object | Where-Object { $null -ne $_.$Field -and $_.$Field -ne '' }

    #$CountBefore = $Object.Count
    #$CountAfter = $ObjectOutput.Count

    return $ObjectOutput
}