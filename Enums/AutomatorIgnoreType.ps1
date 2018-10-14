Add-Type -TypeDefinition @"
    public enum AutomatorIgnoreType {
        Identity,
        Mailbox,
        SamAccountName,
        WindowsEmailAddress
    }
"@