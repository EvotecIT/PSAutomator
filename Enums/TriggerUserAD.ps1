Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum TriggerUserAD {
            Always,
            OrganizationalUnit,
            GroupMembership,
            Filter
        }
    }
"@