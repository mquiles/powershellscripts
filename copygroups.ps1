$WhatIfPreference = $false

$source= Read-host "Enter user to copy from"
$destination  = Read-host " Enter user to copy to"
 Function CopyMembership {

$members = Get-ADUser -Identity $copy -Properties memberof
foreach ($groups in $members.memberof)
    {
    Add-ADGroupMember -Identity $groups -Member $destination -ErrorAction SilentlyContinue
    }
}
CopyMembership
