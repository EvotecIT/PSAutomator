Add-Type -TypeDefinition @"
    public enum AutomatorAction {
        ADAccountDisable,
        ADAccountEnable,
        ADAccountHideInGAL,
        ADAccountShowInGAL,
        ADAccountRename,
        ADAccountRemoveGroupsAll,
        ADAccountRemoveGroupsSecurity,
        ADAccountRemoveGroupsDistribution,
        ADAccountRemoveGroupsSpecific, // Array - Specific groups
        ADAccountRemoveGroupsDomainLocal, // true - false
        ADAccountRemoveGroupsGlobal,  // true - false
        ADAccountRemoveGroupsUniversal  // true - false
    }
"@