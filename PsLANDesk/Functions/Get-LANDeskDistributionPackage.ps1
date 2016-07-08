Function Get-LANDeskDistributionPackage 
{
	<#	
		.SYNOPSIS
			The Get-LANDeskDistributionPackage function returns a list of Distribution packages on the LANDesk Core Server.
		
		.DESCRIPTION
			The Get-LANDeskDistributionPackage function returns a list of Distribution packages on the LANDesk Core Server.

		.EXAMPLE
			Get-LANDeskDistributionPackage
			
			Returns a list of LANDesk distribution packages.
			
		.EXAMPLE
			Get-LANDeskDistributionPackage | Where {$_.PackageName -notlike "*My distribution*"}
			
			Returns only the distribution packages that aren't like My distribution in the package name.
						
		.NOTES
			Working on finding an actual use for this information
			
	#>
	Begin
	{
        $BeginEA = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
		If(!($LANDeskWebService))
		{
			Write-Warning -Message "An active connection to the LANDesk Web Service was not found. Will attempt to connect"
			Try
            {
                Write-Verbose "Connecting to LANDesk server."
                Connect-LANDeskServer
            }
            Catch
            {
                $ErrorActionPreference = $BeginEA
                Write-Error "Could not connect to LANDesk server"
                break
            }
		}
        $ErrorActionPreference = $BeginEA		
	}
	Process 
	{
		$LANDeskPackages = $LANDeskWebService.ListDistributionPackages("").DistributionPackages
		$LANDeskPackages
	}
	End{}
}