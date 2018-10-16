Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum ActionExchangeOnline {
            MailboxConvertToSharedMailbox,  // True/False
            MailboxEmailAddressPolicyEnable, // True/False
            ContactConvertToMailContact // Array
        }
    }
"@