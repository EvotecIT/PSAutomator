Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum Condition {
            EmptyOrNull,
            Field,
            GroupMembership,
            OrganizationalUnit
        }
    }
"@