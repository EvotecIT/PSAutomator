Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum ActionAD {
            AccountAddGroupsSpecific,
            AccountDisable,
            AccountEnable,
            AccountHideInGAL,
            AccountShowInGAL,
            AccountRemoveGroupsAll,
            AccountRemoveGroupsSecurity,
            AccountRemoveGroupsDistribution,
            AccountRemoveGroupsSpecific, // Array - Specific groups
            AccountRemoveGroupsDomainLocal, // true - false
            AccountRemoveGroupsGlobal,  // true - false
            AccountRemoveGroupsUniversal,  // true - false
            AccountRename,
            AccountSnapshot
        }
    }
"@