Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum TriggerComputer {
            Always,
            OrganizationalUnit,
            GroupMembership,
            Filter
        }
    }
"@