Function Get-LANDeskTaskStatus 
{
	<#	
		.SYNOPSIS
			The Get-LANDeskTaskStatus function returns the status of the specified LANDesk task.
		
		.DESCRIPTION
			The Get-LANDeskTaskStatus function returns the status of the specified LANDesk task. Requires the ID number of the task to check which can be found by right-clicking task, selecting info, and copying
			the number in the ID field.
		
		.PARAMETER ID
			The ID of the task to check the status on.

		.EXAMPLE
			Get-LANDeskTaskStatus -ID 877
			
			Returns the status of the LANDesk Task with an ID of 877.
			
		.EXAMPLE
			Get-LANDeskTaskList | Where {$_.TaskName -like "*Adobe*"} | Get-LANDeskTaskStatus
			
			Returns the status of all Landesk tasks with Adobe in their name. Get-LANDeskTaskList creates a list of all of the scheduled tasks on the LANDesk webserver.
						
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipelinebyPropertyName=$true)]
		[alias("TaskID")]
		[int]$ID	
	)
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
		$LANDeskWebService.GetTaskStatus($ID)
	}
	End{}
}