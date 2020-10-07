Get-ADComputer -Filter {OperatingSystem -like "*windows*server*"} -Properties * | sort DNSHostname | select DNSHostName, OperatingSystem | Export-Csv -Path "$home\Desktop\ADServers.csv"
