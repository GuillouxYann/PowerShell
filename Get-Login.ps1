function Get-Login {
    param ($nom, $prenom)

    $login =$nom.ToLower()
    return $login
    
}

$res = Get-Login("Guilloux")
Write-Host $res