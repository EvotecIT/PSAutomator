function Get-WinDocumentationText {
    [CmdletBinding()]
    param (
        [string[]] $Text,
        [Object] $Forest,
        [string] $Domain
    )

    $Replacement = @{
        '<ForestName>'    = $Forest.ForestName
        '<ForestNameDN>'  = $Forest.RootDSE.defaultNamingContext
        '<Domain>'        = $Domain
        '<DomainNetBios>' = $Forest.FoundDomains.$Domain.DomainInformation.NetBIOSName
        '<DomainDN>'      = $Forest.FoundDomains.$Domain.DomainInformation.DistinguishedName
    }
    $Array = @()
    foreach ($T in $Text) {
        foreach ($Key in $Replacement.Keys) {
            if ($T -like "*$Key*") {
                if ($Replacement.$Key) {
                    $T = $T.Replace($Key, $Replacement.$Key)
                } else {
                    Write-Warning "Replacing $Key failed. No value available for substition"
                }
            }
        }
        $Array += $T
    }
    return $Array
}