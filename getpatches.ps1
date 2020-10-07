Foreach($item in(get-content -Path "C:\Users\Public\servers1.txt")) {
Get-hotfix -ComputerName $item | Out-file -Append -FilePath c:\users\public\patches.txt
}
