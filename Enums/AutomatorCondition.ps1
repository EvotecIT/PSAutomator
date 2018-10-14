Add-Type -TypeDefinition @"
    public enum AutomatorCondition {
        RequireGroupMembership,
        RequireLastModified
    }
"@