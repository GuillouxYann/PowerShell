$SITES = "OU=Sites, DC=cos-nanteau,DC=local"
$melun = "OU=Melun,"+$SITES
$nanteau = "OU=Nanteau,"+ $SITES
$torcy = "OU=Torcy," + $SITES
$MAS= "OU=Mas, "+ $nanteau

$ComputerNanteau = (Get-AdComputer -Filter "*" -SearchBase $nanteau | Measure-Object).Count
$ComputerMelun = (Get-AdComputer -Filter "*" -SearchBase $melun | Measure-Object).Count
$ComputerTorcy = (Get-AdComputer -Filter "*" -SearchBase $Torcy | Measure-Object).Count
$ComputerMAS = (Get-ADComputer -Filter "*" -SearchBase $MAS | Measure-Object).Count
$Total= $ComputerNanteau + $ComputerMelun + $ComputerTorcy

Write-Output $Total
Write-Output $ComputerNanteau
Write-Output $ComputerMelun
Write-Output $ComputerTorcy
Write-Output $ComputerMAS

