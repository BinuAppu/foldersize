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
$SizeQuery = Read-Host("Enter the Output size [G = GB & M = MB ; Default GB]")
if($SizeQuery -eq "G"){
    $SizeType = "1GB"
    $type = "GB"

} elseif($SizeQuery -eq "M"){
    $SizeType = "1MB"
    $type = "MB"
} else {
    $SizeType = "1GB"
    $type = "GB"
}
$alldata = Get-ChildItem $query -force
$count = $alldata.count
$objectSchema = @()
$i = 0

foreach($data in $alldata){
    $size = (Get-ChildItem $data.FullName -Recurse -force | Measure-Object -Property Length -Sum).sum
    $sizeval = [math]::Round($size / $SizeType, 2)
    $mode = $data.mode
    $name = $data.Name
    # Write-Host "$sizeinmb | $mode | $name "
    $objectSchema += [PSCustomObject]@{Name = $name; mode= $mode; size="$sizeval $type"}
    $i++
    # Write-Progress -PercentComplete ($i/$count*100) -Status "Processing Items" -Activity "Please Wait !!"
    $perc = [math]::Round($i/$count*100, 2)
    cls
    Write-Host "Query is in Progress for " -NoNewline
    Write-Host "[ $query ]" -ForegroundColor Blue -NoNewline
    Write-Host ". Please Wait !! " -ForegroundColor Yellow

    Write-Host "Percentage Complete : $perc %"
}
$ErrorActionPreference='Continue'
$objectSchema | Out-GridView
$objectSchema