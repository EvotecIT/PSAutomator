Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum Trigger {
            Always,
            OrganizationalUnit,
            GroupMembership
        }
    }
"@