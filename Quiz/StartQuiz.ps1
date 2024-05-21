$ps1Path = "C:\Path1"
$ps2Path = "C:\Path2"
$ps3Path = "C:\Path3"

$backendLocationCommand = "Set-Location -Path \`"$ps2Path\`""
$frontendLocationCommand = "Set-Location -Path \`"$ps3Path\`""

$startBackend = "dotnet watch run --launch-profile https"

$startFrontend = "npm start"

$cdAndStartBackend = "$backendLocationCommand; $startBackend"
$cdAndStartFrontend = "$frontendLocationCommand; $startFrontend"

function StartProcessArguments {
    param (
        [string]$locationAndStart
    )

    return @("-NoExit", "-Command", "& { $locationAndStart }")
}

Set-Location -Path $ps1Path

Start-Process -FilePath "powershell.exe" -ArgumentList (StartProcessArguments -locationAndStart $cdAndStartBackend) -Verb RunAs

Start-Process -FilePath "powershell.exe" -ArgumentList (StartProcessArguments -locationAndStart $cdAndStartFrontend) -Verb RunAs