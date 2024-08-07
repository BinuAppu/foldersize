cls
$host.Ui.RawUI.WindowTitle = "Get FolderSize, Created by: Binu Balan"
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host " "
Write-host "                 _    ____  ____  _   _ "
Write-host "                / \  |  _ \|  _ \| | | |"
Write-host "               / _ \ | |_) | |_) | | | |"
Write-host "              / ___ \|  __/|  __/| |_| |"
Write-host "             /_/   \_\_|   |_|    \___/ "
Write-Host " "
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host " "
Write-host "                 .__." -ForegroundColor Green
Write-host "                   (oo)____" -ForegroundColor Green
Write-host "                   (__)    )\" -ForegroundColor Green
Write-host "                      ll--ll '" -ForegroundColor Green
Write-Host "               SCRIPT BY BINU BALAN               " -ForegroundColor DarkRed -BackgroundColor White
Write-Host "<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>" -ForegroundColor Cyan
Write-Host " "
Start-Sleep -Seconds 2
$ErrorActionPreference='SilentlyContinue'

$query = Read-Host("Enter the Folder Path ")
if($SizeQuery -eq "G"){
    $SizeType = "1GB"
    $type = "GB"

} elseif($SizeQuery -eq "M"){
    $SizeType = "1MB"
} else {
    $SizeType = "1GB"
}
$alldata = Get-ChildItem $query -force
$count = $alldata.count
$objectSchema = @()
$i = 0

$alldata | Foreach-Object -Parallel {
    # $size = (Get-ChildItem $_.FullName -Recurse -force | Measure-Object -Property Length -Sum).sum
    if($_.Extension){
        $size = (Get-Item $_.FullName | Measure-Object -Property Length -Sum).sum
    } else {
        $size = (Get-ChildItem $_.FullName -Recurse -force | Measure-Object -Property Length -Sum).sum
    }
    $sizevalGB = [math]::Round($size / 1GB, 3) 
    $sizevalMB = [math]::Round($size / 1MB, 3) 
    $mode = $_.mode
    $name = $_.Name
    # Write-Host "$size | $mode | $name "
    $objectSchema += [PSCustomObject]@{Name = $name; Mode= $mode; "Size In GB"=$sizevalGB; "Size In MB"=$sizevalMB}
    $objectSchema
}
$ErrorActionPreference='Continue'