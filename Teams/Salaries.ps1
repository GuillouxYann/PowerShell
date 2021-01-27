

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
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU 
$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname

#Connexion à TEAMS 
try {
    Connect-MicrosoftTeams -ErrorAction stop
    }
catch {
    Write-Host "ERREUR: TEAMS Connexion impossible"
    exit
}    

$TeamSalaries = Get-Team -DisplayName "SALARIES"
$id = $TeamSalaries.GroupId 
$pasDeCompte = @()
foreach ($user in $users) 
    {   $mail = $user.samAccountName+"@cosformation.fr"
    try {
        Add-TeamUser -GroupId $id -User $mail -Role "member" -ErrorAction stop
        Write-host $mail "ajouté"
        }
    catch {
        write-host $user.samAccountName "pas de compte O365"
        $pasDeCompte += $user.samAccountName
        }
    }
Disconnect-MicrosoftTeams
 