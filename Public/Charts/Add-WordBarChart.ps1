﻿function Add-WordBarChart {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)][Xceed.Words.NET.Container]$WordDocument,
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)][Xceed.Words.NET.InsertBeforeOrAfter] $Paragraph,
        [string] $ChartName,
        [string[]] $Names,
        [int[]] $Values,
        [Xceed.Words.NET.Series[]] $ChartSeries,
        [ChartLegendPosition] $ChartLegendPosition = [ChartLegendPosition]::Left,
        [bool] $ChartLegendOverlay = $false,
        [BarGrouping] $BarGrouping = [BarGrouping]::Standard,
        [BarDirection] $BarDirection = [BarDirection]::Bar,
        [int] $BarGapWidth = 200,
        [switch] $NoLegend
    )

    if ($ChartSeries -eq $null) {
        $ChartSeries = Add-WordChartSeries -ChartName $ChartName -Names $Names -Values $Values
    }

    [Xceed.Words.NET.BarChart] $chart = New-Object -TypeName Xceed.Words.NET.BarChart
    $chart.BarDirection = $BarDirection
    $chart.BarGrouping = $BarGrouping
    $chart.GapWidth = $BarGapWidth
    if (-not $NoLegend) {
        $chart.AddLegend($ChartLegendPosition, $ChartLegendOverlay)
    }
    foreach ($series in $ChartSeries) {
        $chart.AddSeries($Series)
    }
    if ($Paragraph -eq $null) {
        $WordDocument.InsertChart($chart)
    } else {
        $WordDocument.InsertChartAfterParagraph($chart, $paragraph)
    }
}