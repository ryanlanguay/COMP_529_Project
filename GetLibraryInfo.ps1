# Get the number of libraries in the final built version
$libFolder = "C:\firefox-49.0.2\obj-i686-pc-mingw32\dist\lib"
$binFolder = "C:\firefox-49.0.2\obj-i686-pc-mingw32\dist\bin"
$libCount = (Get-ChildItem $libFolder -File | Where-Object {$_.Extension -ne ".pdb"}).Length + (Get-ChildItem $binFolder -File | Where-Object {$_.Extension -eq ".dll"}).Length
# Get the library to core ratio
$srcExt = @('.js','.cpp','.c','.h')
$srcFiles = Get-ChildItem "C:\firefox-49.0.2" -Recurse -File | Where-Object {$_.Extension -in $srcExt}
$coreSize = 0
$libSize = 0
(Get-ChildItem $libFolder -File | Where-Object {$_.Extension -ne ".pdb"}) + (Get-ChildItem $binFolder -File | Where-Object {$_.Extension -eq ".dll"}) | ForEach-Object {
    $libSize += $_.Length
}
$srcFiles | ForEach-Object {
    $coreSize += $_.Length
}
Write-Host "Total libraries: $libCount
Library : core ratio: $coreSize`:$libSize
"

Write-Host $((Get-ChildItem "C:\firefox-49.0.2\obj-i686-pc-mingw32\msvc\projects" | Where-Object {$_.Name -match 'library_*'}).Length / 2)