Function Start-LANDeskQuery
{
	<#	
		.SYNOPSIS
			The Start-LANDeskQuery function runs the specified LANDesk query and returns the results.
		
		.DESCRIPTION
			The Start-LANDeskQuery function runs the specified LANDesk query and returns the results using the Webservice object.
		
		.PARAMETER QueryName
			The name of the query to run.

		.EXAMPLE
			Start-LANDeskQuery "NewQuery"
			
			Runs the NewQuery query and returns the results.
			
	#>
	[CmdletBinding(SupportsShouldProcess=$true)]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[string]$QueryName	
	)
	Begin
	{
		If(!($LANDeskWebService))
		{
			Write-Warning -Message "An active connection to the LANDesk Web Service was not found. Please run Connect-LANDeskServer before any other functions."
            break
        }		
	}
	Process 
	{
        If($PSCmdlet.ShouldProcess("$QueryName","Starting query on LANDesk server"))
        {
		    $queryResults = $LANDeskWebService.RunQuery("$QueryName")
		    $queryDevicesReturned = ForEach($QueryResult in $queryResults.tables[0].rows)
		    {
			    $QueryResult
		    }
		    $queryDevicesReturned
        }	
	}
	End{}
}