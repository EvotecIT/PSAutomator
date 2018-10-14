Add-Type -TypeDefinition @"
    public enum AutomatorActionAD {
        AccountDisable,
        AccountEnable,
        AccountHideInGAL,
        AccountShowInGAL,
        AccountRename,
        AccountRemoveGroupsAll,
        AccountRemoveGroupsSecurity,
        AccountRemoveGroupsDistribution,
        AccountRemoveGroupsSpecific, // Array - Specific groups
        AccountRemoveGroupsDomainLocal, // true - false
        AccountRemoveGroupsGlobal,  // true - false
        AccountRemoveGroupsUniversal  // true - false
    }
"@