function Submit-ActionExchange {
    [CmdletBinding()]
    param(
        $Object,
        $Action
    )
    foreach ($User in $Object.ProcessingData.Users) {
        switch ( $Action.Action ) {
            MailboxConvertToSharedMailbox {

            }
            MailboxEmailAddressPolicyEnable {

            }
            ContactConvertToMailContact {

            }
            MailboxRemoteEnable {

            }
        }
    }
}

function Set-WinExchangeRemoteMailbox {
    param(

    )

    $RemoteRoutingAddress = ''
    Enable-RemoteMailbox -Identity $User.DistinguishedName -RemoteRoutingAddress $RemoteRoutingAddress
}

