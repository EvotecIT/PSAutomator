Function Service {
    param(
        [Parameter(Mandatory = $true, Position = 0)][string] $Name,
        [Alias('Tags')][string[]] $Tag = @(),
        [Parameter(Position = 1)][ValidateNotNull()][ScriptBlock] $Fixture = $(Throw "No test script block is provided. (Have you put the open curly brace on the next line?)")
    )
    Write-Color -Text 'Running Service', ' for ', $Name -Color White, White, Green
    $Final = Invoke-Command $Fixture
    return
}