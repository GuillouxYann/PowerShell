

#Connexion au domaine
Try {
    Test-Connection   "vad3.cos-nanteau.local"
}
Catch {
    Write-Host "impossible de se connecter au domaine"
    exit
}

#Récupération des Utilisateurs CRPF
$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU -Properties city
$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname

#Connexion à TEAMS 
try {
    Connect-MicrosoftTeams
    }
}
catch {
    Write-Host "Impossible de se connecter à Teams"
    exit
}    

$testYG = New-Team -DisplayName "TESTYG" -Visibility "private" -Owner "yguilloux@cosformation.fr"
$id = $testYG.GroupId 

foreach ($user in $users) 
    {   $mail = $user.samAccountName+"@cosformation.fr"
    try {
        Add-TeamUser -GroupId $id -User $mail -Role "member"
        }
    catch {
        $pasDeCompte += $user.samAccountName
        }
    }