#Récupère la liste des salariés du CRPF
$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU -Properties city

$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname

Connect-MicrosoftTeams
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
 
