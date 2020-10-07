$WhatIfPreference = $true
$CSVFilePath = ""

import-csv $CSVFilePath | ForEach-Object {

    $SamAccountName=$_.SamAccountName

    $UserPrincipalName=$_.SamAccountName + '@domain'
    #$Name=$_.GivenName + ' ' + $_.Initials + ' ' +  $_.Surname
    $Name=$_.GivenName + ' ' +  $_.Surname
    $Password=$_.Password      
    #$DisplayName=$_.GivenName + ' ' +  $_.Initials + ' ' +  $_.Surname
    $DisplayName=$_.GivenName + ' ' +  $_.Surname
    $GivenName=$_.GivenName
    #$Initials = $_.Initials
    $SurName=$_.Surname
    #$Path="OU=,OU=,DC=,DC=,DC="
    

             #$Department =  $_.Department
             #$Title = $_.Title
             #$EmailAddress = $_.EmailAddress
    
     
    #PassThru = $true
            



new-aduser -server "servername here" -name $Name -GivenName $GivenName -Initials $Initials –surname $SurName -DisplayName $DisplayName -Department $Department  -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -force) -Enabled $true -changepasswordatlogon $true -samaccountname $SamAccountName –userprincipalname $UserPrincipalName -Path $Path 
} 
#-ErrorAction Stop
