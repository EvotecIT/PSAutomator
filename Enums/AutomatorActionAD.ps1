Add-Type -TypeDefinition @"
    public enum AutomatorActionAD {
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
        AccountRename
    }
"@