
Add-Type -TypeDefinition @"
    public enum AutomatorActionExchange {
        MailboxConvertToSharedMailbox,  // True/False
        MailboxEmailAddressPolicyEnable, // True/False
        ContactConvertToMailContact // Array
    }
"@