# Source code file extensions ot search for (Firefox is implemented in C++, C, and JavaScript)
$srcExt = @('.js','.cpp','.c','.h')
# Regex patterns for comments, functions, and objects in C++
$commentPatterns = '/\**|//*|\*\**|\*/'
$functionPattern = '.*\){*|.*\(`r`n{*'
$objPattern = '.*class.*|.*struct.*;'
# Get all source files in the src directory
$srcFiles = Get-ChildItem "C:\firefox-49.0.2" -Recurse -File | Where-Object {$_.Extension -in $srcExt}
$totalLines = 0
$commentLines = 0
$functions = 0
$objects = 0
ForEach ($file in $srcFiles)
{
    # Check each line in this file for comments, functions, and objects. Read 1000 at a time for performance reasons
    Get-Content $file.FullName -ReadCount 1000 | ForEach-Object {
        $totalLines += $_.Length
        switch ($_)
        {
            ({$_ -match $commentPatterns})
            {
                $commentLines++
                break
            }
            ({$_ -match $functionPattern})
            {
                $functions++
                break
            }
            ({$_ -match $objPattern})
            {
                $objects++
                break
            }
            default
            {
                break
            }
        }
    }
}
Write-Host "Total lines of code: $totalLines
Commented lines: $commentLines
Functions: $functions
Objects: $objects
"