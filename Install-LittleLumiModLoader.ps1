$ErrorActionPreference = 'Stop'

$steam = (Get-ItemProperty 'HKCU:\Software\Valve\Steam' -ErrorAction Stop).SteamPath
$libraryFile = Join-Path $steam 'steamapps\libraryfolders.vdf'
$libraries = @($steam) + ([regex]::Matches((Get-Content -LiteralPath $libraryFile -Raw), '"path"\s+"([^"]+)"') |
    ForEach-Object { $_.Groups[1].Value.Replace('\\', '\') })
$installers = @(foreach ($library in ($libraries | Select-Object -Unique)) {
    $workshopRoot = Join-Path $library 'steamapps\workshop\content\5075020'
    Get-ChildItem -LiteralPath $workshopRoot -Filter 'lumimodloader.json' -Recurse -File -ErrorAction SilentlyContinue |
        ForEach-Object { Join-Path $_.Directory.FullName 'Install.ps1' }
}) | Where-Object { Test-Path -LiteralPath $_ }

if ($installers.Count -ne 1) {
    throw 'Subscribe to exactly one Little LUMI Model Mod Loader Workshop item before installing.'
}

& $installers[0]
