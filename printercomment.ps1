$PrinterListToUnshare = Get-Content "C:\Users\Public\printers.txt"
Foreach ($Printer in $PrinterListToUnshare) {
Set-Printer -Name $Printer -shared $false
}
