Function Get-LANDeskAgentBehaviors
{
	<#	
		.SYNOPSIS
			Returns all of the agent behaviors on the connected LANDesk webservice. AgentBehavior Id number is used as input for scheduling patches
		
		.DESCRIPTION
			Returns all of the agent behaviors on the connected LANDesk webservice. Uses the GetAgentBehaviors method
			of the LANDesk Web Service object.

		.EXAMPLE
			Get-LANDeskAgentBehaviors
			
			Retruns an object with the name and ID of the Agent Behvaiors on the connected LANDesk webservice.			
	#>
	[CmdletBinding()]
	param()
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
		Write-Verbose -Message "Starting to loop through Agent Behaviors"
		$i = 0
		Do
		{
			Write-Verbose -Message "Getting Agent Behaviors an int value of $($i)"
			$Behaviors = $LANDeskWebService.GetAgentBehaviors($i)
			$count = $Behaviors.count
			$i++
			Write-Verbose -Message "Adding Agent Behaviors to array for further processing"
			[array]$AgentBehaviors += $Behaviors
		}
		Until($count -eq 0)
		Write-Verbose -Message "Manipulating Agent Behaviors array to return single object with Name and ID"
		$Behaviors = ForEach($AgentBehavior in $AgentBehaviors)
		{
			$AgentBehavior.AgentBehaviors
		}
		$Behaviors
	}
	End{}
}