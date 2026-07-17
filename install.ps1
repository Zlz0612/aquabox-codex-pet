[CmdletBinding()]
param(
    [string]$CodexHome
)

$ErrorActionPreference = 'Stop'
$RawBase = 'https://raw.githubusercontent.com/Zlz0612/aquabox-codex-pet/main'

if (-not $CodexHome) {
    $CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
}

$TargetDir = Join-Path $CodexHome 'pets\aquabox'
$TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("aquabox-codex-pet-" + [guid]::NewGuid().ToString('N'))

try {
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    $PetJson = Join-Path $TempDir 'pet.json'
    $SpriteSheet = Join-Path $TempDir 'spritesheet.webp'

    Invoke-WebRequest -Uri "$RawBase/pet.json" -OutFile $PetJson
    Invoke-WebRequest -Uri "$RawBase/spritesheet.webp" -OutFile $SpriteSheet

    # Windows PowerShell 5.1 otherwise reads UTF-8-without-BOM JSON using the
    # active ANSI code page, which corrupts the Chinese metadata.
    $MetadataText = [System.IO.File]::ReadAllText($PetJson, [System.Text.Encoding]::UTF8)
    $Metadata = $MetadataText | ConvertFrom-Json
    if ($Metadata.id -ne 'aquabox' -or $Metadata.spriteVersionNumber -ne 2) {
        throw 'Downloaded pet.json is not the expected AquaBox v2 pet.'
    }

    $Bytes = [System.IO.File]::ReadAllBytes($SpriteSheet)
    if ($Bytes.Length -lt 12 -or
        [System.Text.Encoding]::ASCII.GetString($Bytes, 0, 4) -ne 'RIFF' -or
        [System.Text.Encoding]::ASCII.GetString($Bytes, 8, 4) -ne 'WEBP') {
        throw 'Downloaded spritesheet.webp is not a valid WebP file.'
    }

    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    Copy-Item -LiteralPath $PetJson -Destination (Join-Path $TargetDir 'pet.json') -Force
    Copy-Item -LiteralPath $SpriteSheet -Destination (Join-Path $TargetDir 'spritesheet.webp') -Force

    Write-Host "Installed AquaBox to $TargetDir"
    Write-Host 'Fully quit and reopen Codex, then use Settings > Pets > Refresh.'
}
finally {
    if (Test-Path -LiteralPath $TempDir) {
        Remove-Item -LiteralPath $TempDir -Recurse -Force
    }
}
