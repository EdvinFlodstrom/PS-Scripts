param(
    [Parameter(Mandatory = $true)]
    [string]$dirName,

    [bool]$git = $true
)

$path = (Get-ChildItem -Recurse -Directory "~/" | Where-Object Name -Like $dirName).FullName

if (-not $path) {
    Throw "The provided directory name was not found in '~/'."
}

Set-Location $path
if ($git) {
    & git status
}