Add-Type -TypeDefinition @"
    public enum AutomatorTrigger {
        Always,
        OrganizationalUnit,
        GroupMembership
    }
"@