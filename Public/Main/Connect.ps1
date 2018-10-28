function Connect {
    [CmdletBinding()]
    param (
        [PSAutomator.Connect] $Service,
        [string] $UserName,
        [string] $Password,
        [switch] $AsSecure,
        [switch] $FromFile
    )
}