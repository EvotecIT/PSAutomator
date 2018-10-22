Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum TriggerUser {
            Always,
            OrganizationalUnit,
            GroupMembership,
            Filter
        }
    }
"@