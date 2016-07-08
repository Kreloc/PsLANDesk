Function Get-LANDeskTaskList 
{
	<#	
		.SYNOPSIS
			Lists the tasks on the landesk server.
		
		.DESCRIPTION
			Lists the tasks on the LANDesk server and creates an object that can be piped to other functions.

		.EXAMPLE
			Get-LANDeskTaskList
			
			Outputs a list of all of the LANDesk scheduled tasks as an object.
			
		.EXAMPLE
			Get-LANDeskTaskList | Where {$_.FailedTargetCount -gt 0}
			
			Returns a list of all scheduled tasks that have failed computers in them.
			
	#>
	[CmdletBinding()]
	param()
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
		 $LANDeskWebService.ListSWDTasks().ScheduledTasks	
	}
	End{}
}