param (
    [Parameter(Mandatory = $true)]
    [string]$inputFilePath,

    [Parameter(Mandatory = $true)]
    [string]$outputFolderPath
)

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

    # Save modified document as PDF. # 17 is the wdFormatPDF constan
    $tempDoc.SaveAs([ref] $outputFilePath, [ref] 17)

    Write-Host "Successfully created PDF of .docx file."
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