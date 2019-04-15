﻿function Set-WordTextText {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)][Xceed.Words.NET.InsertBeforeOrAfter] $Paragraph,
        [alias ("S")][AllowNull()] $Text,
        [switch]$Append,
        [bool] $Supress = $false
    )
    if ($Paragraph -ne $null) {
        if ($Text -ne $null) {
            if ($Text -isnot [String]) { throw 'Invalid argument for parameter -Text.' }
            if ($Append -ne $true) { $Paragraph = Remove-WordText -Paragraph $Paragraph }
            Write-Verbose "Set-WordTextText - Appending Value $Text"
            $Paragraph = $Paragraph.Append($Text)
        }
    }
    if ($Supress) { return } else { return $Paragraph }
}