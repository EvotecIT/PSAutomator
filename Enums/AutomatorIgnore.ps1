Add-Type -TypeDefinition @"
    public enum AutomatorIgnore {
        MatchingEmptyOrNull,
        MatchingObjects,
        MatchingFields
    }
"@