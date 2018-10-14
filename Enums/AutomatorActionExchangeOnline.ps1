Add-Type -TypeDefinition @"
public enum AutomatorActionExchangeOnline {
    MailboxConvertToSharedMailbox,  // True/False
    MailboxEmailAddressPolicyEnable, // True/False
    ContactConvertToMailContact // Array
}
"@