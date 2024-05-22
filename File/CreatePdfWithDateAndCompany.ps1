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
$outputFileName = $companyName + ".pdf"
$outputFilePath = (Resolve-Path -Path $outputFolderPath).Path + $outputFileName

# Word application object
$word = New-Object -ComObject Word.Application
$word.Visible = $false

try {
    $inputFileAbsPath = (Resolve-Path -Path $inputFilePath).Path

    $doc = $word.Documents.Open($inputFileAbsPath)

    $tempFilePath = [System.IO.Path]::GetTempFileName() + '.docx'
    $doc.SaveAs([ref] $tempFilePath)
    $doc.Close()

    $tempDoc = $word.Documents.Open($tempFilePath)

    $replacementWords = @{
        "[Date]"    = $date
        "[Company]" = $companyName
    }

    $matchCase = $true
    $matchWholeWord = $true
    $matchWildcards = $false
    $matchSoundsLike = $false
    $matchAllWordForms = $false
    $forward = $true
    $findWrap = [ref]1
    $format = $false
    $replace = [ref]2
    
    # Replace some of the words in the copied file's content with the above words
    foreach ($key in $replacementWords.Keys) {
        $find = $tempDoc.Content.Find
        $find.Text = $key
        $find.Replacement.Text = $replacementWords[$key]
        $find.Execute([ref]$find.Text, $matchCase, $matchWholeWord, $matchWildcards, $matchSoundsLike, $matchAllWordForms, $forward, $findWrap, $format, [ref]$find.Replacement.Text, $replace) | Out-Null
    }

    # Save modified document as PDF. # 17 is the wdFormatPDF constan
    $tempDoc.SaveAs([ref] $outputFilePath, [ref] 17)

    Write-Host "Replaced [Date] with $date, and [Company] with $companyName."
}
catch {
    Write-Error "An error occurred: $_"
    if ($_.Exception -and $_.Exception.InnerException) {
        Write-Error "Inner exception: $($_.Exception.InnerException.Message)"
    }
}
finally {
    if ($null -ne $tempDoc) {
        $tempDoc.Close()
    }
    if ($null -ne $word) {
        $word.Quit()
    }

    Remove-Item $tempFilePath -ErrorAction SilentlyContinue
}