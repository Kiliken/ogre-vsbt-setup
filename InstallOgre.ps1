
$BuildProj = $Args[1]
$OgreVersion = $Args[2]
$VSTVersion = $Args[3]

$OgreDownloadUrl = "https://dl.cloudsmith.io/public/ogrecave/ogre/raw/versions/v$OgreVersion/ogre-sdk-v$OgreVersion-msvc$VSTVersion-x64.zip"

$wc = New-Object Net.WebClient
Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-Output "[ogre-vsbt-setup] Downloading ogre-sdk-v$OgreVersion-msvc$VSTVersion-x64..."
$wc.DownloadFile($OgreDownloadUrl, "$($PSScriptRoot)\OGRE.zip")

New-Item -Path "$($PSScriptRoot)\OGRE" -ItemType Directory
Write-Output "[ogre-vsbt-setup] Extracting ogre-sdk-v$OgreVersion-msvc$VSTVersion-x64..."
[System.IO.Compression.ZipFile]::ExtractToDirectory("$($PSScriptRoot)\OGRE.zip", "$($PSScriptRoot)\OGRE")

Copy-Item -Path "$($PSScriptRoot)\OGRE\bin" -Destination "$($PSScriptRoot)" -Recurse
Copy-Item -Path "$($PSScriptRoot)\OGRE\Media" -Destination "$($PSScriptRoot)" -Recurse
Copy-Item -Path "$($PSScriptRoot)\plugins.cfg" -Destination "$($PSScriptRoot)\bin" -Force

return 0
