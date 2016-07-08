Function Get-LANDeskQueries 
{
	<#	
		.SYNOPSIS
			The Get-LANDeskQueries function returns a list of queries available to be run.
		
		.DESCRIPTION
			A detailed description of the Get-LANDeskQueries function.

		.EXAMPLE
			Get-LANDeskQueries
			
			Returns a list of LANDesk queries.
			
		.EXAMPLE
			$ListOfQueries = Get-LANDeskQueries
			$ListOfQueries | Where-Object {$_.QueryName -eq "Current Machines  (scan>10/9/2015)"}
			
			Returns only the query name specified in the Where-Object section of the pipe. This could then be piped directly to the
			Start-LANDeskQuery function included in the PSLANDeskModule.
			
		.NOTES
			Working on integrating Out-Gridview for selecting the query.
			
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
		$LANDeskQueries = $LANDeskWebService.ListQueries()
		$LANDeskQueries
	}
	End{}
}