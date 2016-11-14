$srcExt = @('.js','.cpp','.c','.h','.py')
$srcFiles = Get-ChildItem "C:\firefox-49.0.2" -Recurse -File | Where-Object {$_.Extension -in $srcExt}
$totalLines = 0
$srcFiles | ForEach-Object {
    $totalLines += $($_ | Get-Content | Measure-Object -Line).Count
}