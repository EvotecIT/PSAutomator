Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum TriggerGroup {
            Always,
            OrganizationalUnit,
            Filter
        }
    }
"@