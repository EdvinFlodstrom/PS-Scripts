param (
    [Parameter(Mandatory = $true)]
    [string]$inputFilePath,

    [Parameter(Mandatory = $true)]
    [string]$outputFolderPath,

    [Parameter(Mandatory = $true)]
    [string]$companyName
)

# Current date
$date = (Get-Date).ToString("yyyy-MM-dd")

# Ensure folder path ends with a backslash
if (-not $outputFolderPath.EndsWith("\")) {
    $outputFolderPath += "\"
}

# Construct the new file name and its path
$outputFileName = $companyName + ".txt"
$outputFilePath = $outputFolderPath + $outputFileName

Copy-Item $inputFilePath -Destination $outputFilePath

$fileCopyContent = Get-Content -Path $outputFilePath

$replacementWords = @{
    "\[Datum\]"   = $date
    "\[Företag\]" = $companyName
}

# Replace some of the words in the copied file's content with the above words
foreach ($key in $replacementWords.Keys) {
    $fileCopyContent = $fileCopyContent -replace $key, $replacementWords[$key]
}

Set-Content -Path $outputFilePath -Value $fileCopyContent

Write-Host "Replaced [Datum] with $date, and [Företag] with $companyName."