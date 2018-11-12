Function Trigger {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)] $Object,
        [parameter(Mandatory = $false)] [string] $Name,
        [parameter(Mandatory = $false, ParameterSetName = "User")][PSAutomator.TriggerUserAD] $User,
        [parameter(Mandatory = $false, ParameterSetName = "UserAzureAD")][PSAutomator.TriggerUserAzureAD] $UserAzureAD,
        [parameter(Mandatory = $false, ParameterSetName = "Group")][PSAutomator.TriggerGroup] $Group,
        [parameter(Mandatory = $false, ParameterSetName = "Computer")][PSAutomator.TriggerComputer] $Computer,
        [parameter(Mandatory = $false)] [Object] $Value
    )
    Begin {

    }
    Process {
        if ($null -eq $Object) {
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
            UserAD {
                $Trigger.Trigger = $User
            }
            UserAzureAD {
                $Trigger.Trigger = $UserAzureAD
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