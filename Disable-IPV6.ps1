Function Disable-IPv6 {

    <#
    .SYNOPSIS
    Disable IPV6 for all the adaptaters
    .DESCRIPTION 
    Disable IPV6  for all  the network Adaptaters (YGX 2020/06) 
    .PARAMETER None
    No parameter is needed 
    .EXAMPLE 
    Disable-IPv6 
    #>

    [CmdletBinding()]
    param (
    )
    $interfaces = Get-NetAdapter
    foreach ($interface in $interfaces ) {
        Disable-NetAdapterBinding -InterfaceAlias $interface.Name -ComponentID ms_tcpip6
        Write-Verbose $interface.Name , "==> IPv6 disabled"
    }
}

    