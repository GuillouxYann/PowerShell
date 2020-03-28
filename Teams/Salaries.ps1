

#Connexion au domaine
Try {
    Test-Connection   "vad3.cos-nanteau.local" -Quiet -Count 1 -ErrorAction stop
}
Catch {
    Write-Host "ERREUR: DOMAINE Connexion Impossible"
    exit
}

#Récupération des Utilisateurs CRPF
$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU -Properties city
$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname

#Connexion à TEAMS 
try {
    Connect-MicrosoftTeams -ErrorAction stop
    }
catch {
    Write-Host "ERREUR: TEAMS Connexion impossible"
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