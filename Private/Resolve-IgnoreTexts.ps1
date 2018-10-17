function Resolve-IgnoreTexts {
    param (
        [string[]] $IgnoreText
    )
    $Ignores = New-ArrayList
    foreach ($Ignore in $IgnoreText) {
        if ($Script:ActiveDirectory.Domains) {
            foreach ($Domain in $Script:ActiveDirectory.Domains) {
                $Text = Get-WinDocumentationText -Text $Ignore -Forest $Script:ActiveDirectory.Forest -Domain $Domain
                Add-ToArrayAdvanced -List $Ignores -Element $Text -SkipNull -RequireUnique
            }
        } else {
            $Text = Get-WinDocumentationText -Text $Ignore -Forest $Script:ActiveDirectory.Forest -Domain ''
            Add-ToArrayAdvanced -List $Ignores -Element $Text -SkipNull -RequireUnique
        }
    }
    return $Ignores
}
