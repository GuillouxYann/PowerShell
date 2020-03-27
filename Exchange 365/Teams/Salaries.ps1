$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU -Properties city

$Logins =  $CRPF | Select-Object samaccountname | Sort-Object  
$Logins | Format-Table  
