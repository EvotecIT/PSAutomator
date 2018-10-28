function Start-Configuration {
    param(
        $Configuration
    )
    Out-ConfigurationStatus -Option 'Start'
    if ($Configuration.Services.OnPremises.ActiveDirectory.Use) {
        $CommandOutput = Connect-WinService -Type 'ActiveDirectory' `
            -Credentials $Configuration.Services.OnPremises.ActiveDirectory.Credentials `
            -Service $Configuration.Services.OnPremises.ActiveDirectory -Verbose:$false -Output
        Out-ConnectionStatus -CommandOutput $CommandOutput
    }
    if ($Configuration.Services.OnPremises.Exchange.Use) {
        $CommandOutput = Connect-WinService -Type 'Exchange' `
            -Credentials $Configuration.Services.OnPremises.Exchange.Credentials `
            -Service $Configuration.Services.OnPremises.Exchange -Verbose:$false -Output
        Out-ConnectionStatus -CommandOutput $CommandOutput
    }
    if ($Configuration.Services.Office365.Azure.Use) {
        $CommandOutput = Connect-WinService -Type 'Azure' `
            -Credentials $Configuration.Services.Office365.Credentials `
            -Service $Configuration.Services.Office365.Azure -Verbose:$false -Output
        Out-ConnectionStatus -CommandOutput $CommandOutput
    }
    if ($Configuration.Services.Office365.AzureAD.Use) {
        $CommandOutput = Connect-WinService -Type 'AzureAD' `
            -Credentials $Configuration.Services.Office365.Credentials `
            -Service $Configuration.Services.Office365.AzureAD -Verbose:$false -Output
        Out-ConnectionStatus -CommandOutput $CommandOutput
    }
    if ($Configuration.Services.Office365.ExchangeOnline.Use) {
        $CommandOutput = Connect-WinService -Type 'ExchangeOnline' `
            -Credentials $Configuration.Services.Office365.Credentials `
            -Service $Configuration.Services.Office365.ExchangeOnline -Verbose:$false -Output
        Out-ConnectionStatus -CommandOutput $CommandOutput
    }
    Out-ConfigurationStatus -Option 'End'
}