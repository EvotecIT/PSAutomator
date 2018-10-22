Function Trigger {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)] $Object,
        [parameter(Mandatory = $false)] [string] $Name,
        [parameter(Mandatory = $false, ParameterSetName = "User")][PSAutomator.TriggerUser] $User,
        [parameter(Mandatory = $false, ParameterSetName = "Group")][PSAutomator.TriggerGroup] $Group,
        [parameter(Mandatory = $false, ParameterSetName = "Computer")][PSAutomator.TriggerComputer] $Computer,
        [parameter(Mandatory = $false)] [Object] $Value
    )
    Begin {

    }
    Process {
        if ($Object -eq $null) {
            # if object is null it's the first one
            $Object = [ordered] @{
                Triggers       = @()
                Conditions     = @()
                Ignores        = @()
                Actions        = @()
                ProcessingData = @{
                    Users = @()
                }
            }
        }
        $Trigger += @{
            Name  = $Name
            Value = $Value
            Type  = $PSCmdlet.ParameterSetName
        }
        switch ($PSCmdlet.ParameterSetName) {
            User {
                $Trigger.Trigger = $User
            }
            Group {
                $Trigger.Trigger = $Group
            }
            Computer {
                $Trigger.Trigger = $Computer
            }
        }
        $Object.Triggers += $Trigger
    }
    End {
        return $Object
    }
}