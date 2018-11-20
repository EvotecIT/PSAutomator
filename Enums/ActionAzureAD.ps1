Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum ActionAzureAD {
            AccountAddGroupsSpecific,
            AccountDisable,
            AccountEnable,
            AccountRemoveGroupsAll,
            AccountRemoveGroupsSecurity,
            AccountRemoveGroupsDistribution,
            AccountRemoveGroupsSpecific, // Array - Specific groups
            AccountRename,
            AccountSnapshot,
            AddLicense,
            RemoveLicense,
            RemoveLicenseAll,
            ReplaceLicense,
            EnableMFA,
            DisableMFA,
            SetUserRole,
            SetField,
            SynchronizeFields
        }
    }
"@