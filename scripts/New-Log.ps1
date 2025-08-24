param([string]$Title = "")
$Root = Split-Path -Parent $PSScriptRoot
$Date = Get-Date -Format "yyyy-MM-dd"
$template = Get-Content "$Root\daily_log_template.md" -Raw
$content = $template.Replace("{{DATE}}",$Date).Replace("{{TITLE}}", $(if($Title){"- $Title"} else {""}))
$out = Join-Path $Root "logs\$Date.md"
$content | Set-Content -Path $out -Encoding UTF8
Write-Host "Created $out"

# update README index
$readme = Join-Path $Root "README.md"
$text = Get-Content -Raw $readme
$marker = "## Daily Log Index"
$link = "- [$Date](logs/$Date.md)"
if ($text -notmatch [regex]::Escape($link) -and $text -match $marker) {
  $parts = $text -split $marker, 2
  $firstNl = $parts[1].IndexOf("`n")
  $new = $parts[0] + $marker + "`n" + $link + "`n" + $parts[1].Substring($firstNl+1)
  $new | Set-Content -Path $readme -Encoding UTF8
  Write-Host "README updated."
}
