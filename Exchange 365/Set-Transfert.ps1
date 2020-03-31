#YGX 23/03/2020
#YGX Automatisation du transfert vers fondatiocos.org 


#Ouverture de Session sur Exchange 365 
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

#Parcourt  de la liste des Users
Try {
    Test-Connection   "vad3.cos-nanteau.local" -Quiet -Count 1 -ErrorAction stop
}
Catch {
    Write-Host "ERREUR: DOMAINE Connexion Impossible"
    exit
}

#Récupération des Utilisateurs CRPF
$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU 
$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname
forEach ($item in $users) {
    $user=$item.Samaccountname+"@cosformation.fr"
    $ForwardingEmail=$item.Samaccountname+"@fondationcos.org"
    Set-Mailbox -Identity $user  -DeliverToMailboxAndForward $true -ForwardingSMTPAddress $ForwardingEmail
    Write-Host  $user
}

#Fin de Session Exchange 365
Remove-PSSession $Session
