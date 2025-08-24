$d = Get-Date -Format "yyyy-MM-dd"
git add -A
git commit -m "daily: $d update"
git push
