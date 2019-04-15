$PSVersionTable.PSVersion

$ModuleName = (Get-ChildItem $PSScriptRoot\*.psd1).BaseName
#$ModuleVersion = (Get-Content -Raw $PSScriptRoot\*.psd1)  | Invoke-Expression | ForEach-Object ModuleVersion

#$Dest = "Builds\$ModuleName-{0}-{1}.zip" -f $ModuleVersion, (Get-Date).ToString("yyyyMMddHHmmss")
#Compress-Archive -Path . -DestinationPath .\$dest

if ($null -eq (Get-Module -ListAvailable pester)) {
    Write-Warning "$ModuleName - Downloading Pester from PSGallery"
    Install-Module -Name Pester -Repository PSGallery -Force -SkipPublisherCheck
}
if ($null -eq (Get-Module -ListAvailable PSSharedGoods)) {
    Write-Warning "$ModuleName - Downloading PSSharedGoods from PSGallery"
    Install-Module -Name PSSharedGoods -Repository PSGallery -Force
}

Import-Module PSSharedGoods -Force
Import-Module $PSScriptRoot\PSWriteWord.psd1 -Force

$result = Invoke-Pester -Script $PSScriptRoot\Tests -Verbose -EnableExit

if ($result.FailedCount -gt 0) {
    throw "$($result.FailedCount) tests failed."
}