# Example command-line:
# > .\build.ps1 5.0.1

&("C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe") LinqToTwitter.proj -p:Version=$args

$DeploymentFolder = "C:\Projects\NuGet\LinqToTwitter-v5\"
$SourceFolderBase = $DeploymentFolder + "v" + $args + "\lib\"

$Date = Get-Date
$FileDate = $Date.ToString("yyyyMMdd")

$FolderNames =
@(
	"net48",
    "uap10.0",
	"xamarin.ios",
	"xamarin.mac",
    "monoandroid",
    "netcoreapp3.1",
    "netstandard2.0"
)

$ZipFileName = $DeploymentFolder + "LinqToTwitter_" + $FileDate + ".zip"

set-content $ZipFileName ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18)) 
(Get-ChildItem $ZipFileName).IsReadOnly = $false

$ZipFile = (new-object -com Shell.Application).Namespace($ZipFileName)
$activity = 'Zipping file to ' + $ZipFile.Name + ': '

for ($i=0; $i -lt $FolderNames.Length; $i++)
{
	$CurrentFolder = $SourceFolderBase + $FolderNames[$i]
	$SourceFolder = Get-Item $CurrentFolder
	Write-Progress -activity $activity -status $SourceFolder.FullName
	$ZipFile.CopyHere($SourceFolder.FullName)
	Start-sleep -milliseconds 750
}

$SourceFolder = Get-Item $SourceFolderBase
Write-Progress -activity $activity -status $SourceFolder.FullName

Start-sleep -milliseconds 750

$ReadMe = ".\ReadMe.txt"
$ReadMeFile = Get-Item $ReadMe
$ZipFile.CopyHere($ReadMeFile.FullName)
Start-sleep -milliseconds 750
