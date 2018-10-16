Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum Condition {
            RequireGroupMembership,
            RequireLastModified
        }
    }
"@