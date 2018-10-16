Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum IgnoreType {
            Identity,
            Mailbox,
            SamAccountName,
            WindowsEmailAddress
        }
    }
"@