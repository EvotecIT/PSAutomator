Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum ActionExchange {
            MailboxConvertToSharedMailbox,  // True/False
            MailboxEmailAddressPolicyEnable, // True/False
            ContactConvertToMailContact // Array
        }
    }
"@