#Récupère la liste des salariés du CRPF
$OU = "OU=Users CRPF,OU=Utilisateurs,DC=cos-nanteau,DC=local"
$CRPF = Get-ADUser -Filter "*" -SearchBase $OU -Properties city

$users =  $CRPF | Select-Object samaccountname | Sort-Object samaccountname

Connect-MicrosoftTeams
$TestYG = New-Team -DisplayName "TESTYG" -Visibility "private" -Owner "yguilloux@cosformation.fr"
$ID = $TestYG.GroupId 

foreach ($user in $users) 
{   $mail = $user+"@cosformation.fr"
    Add-TeamUser -GroupId $ID -User $mail -Role "member"
 }