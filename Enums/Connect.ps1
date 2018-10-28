Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        public enum Connect {
            ActiveDirectory,
            Azure,
            AzureAD,
            Exchange,
            ExchangeOnline
        }
    }
"@