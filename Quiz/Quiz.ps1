$ps1Path = "C:\Path1"
$ps2Path = "C:\Path2"
$ps3Path = "C:\Path3"

$backendLocationCommand = "Set-Location -Path \`"$ps2Path\`""
$frontendLocationCommand = "Set-Location -Path \`"$ps3Path\`""

function StartProcessArguments {
    param (
        [string]$locationCommand
    )
    "-NoExit",
    "-Command",
    $locationCommand
}

Set-Location -Path $ps1Path

Start-Process -FilePath "powershell.exe" -ArgumentList (StartProcessArguments -locationCommand $backendLocationCommand) -Verb RunAs

Start-Process -FilePath "powershell.exe" -ArgumentList (StartProcessArguments -locationCommand $frontendLocationCommand) -Verb RunAs