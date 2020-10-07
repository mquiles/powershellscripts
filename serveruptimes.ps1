
Function Get-Uptime {
 
    [CmdletBinding()]
 
    Param (
        [Parameter(
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
 
        [string[]]
            $ComputerName = $env:COMPUTERNAME,
         
        [Switch]  
            $ShowOfflineComputers
     
        )
 
    BEGIN {
        $ErroredComputers = @()
    }
 
    PROCESS {
        Foreach ($Computer in $ComputerName) {
            Try {
                $OS = Get-WmiObject Win32_OperatingSystem -ComputerName $Computer -ErrorAction Stop
                $Uptime = (Get-Date) - $OS.ConvertToDateTime($OS.LastBootUpTime)
                $Properties = @{ComputerName  = $Computer
                                LastBoot      = $OS.ConvertToDateTime($OS.LastBootUpTime)
                                Uptime        = ([String]$Uptime.Days + " Days " + $Uptime.Hours + " Hours " + $Uptime.Minutes + " Minutes ")
                                }
 
                $Object = New-Object -TypeName PSObject -Property $Properties | Select-Object ComputerName, LastBoot, UpTime
 
            } catch {
                if ($ShowOfflineComputers) {
                    $ErrorMessage = $Computer + " Error: " + $_.Exception.Message
                    $ErroredComputers += $ErrorMessage
 
                    $Properties = @{ComputerName  = $Computer
                                    LastBoot      = "Unable to Connect"
                                    Uptime        = "Server Shut off or has Issue. Please check"
                                    }
 
                    $Object = New-Object -TypeName PSObject -Property $Properties | Select-Object ComputerName, LastBoot, UpTime
                }
                
            } finally {
                Write-Output $Object       
 
                $Object       = $null
                $OS           = $null
                $Uptime       = $null
                $ErrorMessage = $null
                $Properties   = $null
            }
        }
     
        if ($ShowOfflineComputers) {
            Write-Output ""
            Write-Output "Errors for Computers not able to connect."
            Write-Output $ErroredComputers
        }
    }
 
    END {}
 
}

$Servers = Get-Content -path ""

#Get all reboot times and put them in a variable to reference later.
$Reboot = Restart-Computer -ComputerName $Servers -Force

$VMUptime= Get-Uptime -ComputerName $Servers -ShowOfflineComputers

Write-Output $VMUptime

$Reboot


#Sorting by Lastboot time. 
# $final_results = $Reboots | ConvertTo-Html | Out-String 



# $body = $final_results 
# #| ConvertTo-HTML -Head ("System Information for: {0}" -f  $computerSystem.Name)

# $mailParams = @{
#     To = ""
#     From = ""
#     Subject = "Server Uptimes"
#     Body = $body
#     BodyAsHtml = $true
#     SmtpServer = ""
# }

# Send-MailMessage @mailParams
