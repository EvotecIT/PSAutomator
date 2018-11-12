Add-Type -TypeDefinition @"
using System;

    namespace PSAutomator
    {
        [Flags]
        public enum Ignore {
            MatchingEmptyOrNull,
            MatchingFields
        }
    }
"@