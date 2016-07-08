Function Get-LANDeskMachineVulnerabilities 
{
	<#	
		.SYNOPSIS
			The Get-LANDeskMachineVulnerabilities function returns the vulnerabilities for specified device.
		
		.DESCRIPTION
			The Get-LANDeskMachineVulnerabilities function returns the vulnerabilities for specified device and sorts them by severity.
		
		.PARAMETER GUID
			The GUID of the device to check for vulnerabilities. Obtained from running Get-LANDeskComputer

		.EXAMPLE
			Get-LANDeskMachineVulnerabilities <GUID>
			
			Finds and returns vulnerabilities for the selected device.
			
		.EXAMPLE
			Get-LANDeskComputer -Filter {$_.ComputerName -like "Pre-*"} | Get-LANDeskMachineVulnerabilities
		
			Returns vulnerabilies found for the all of the computers returned by Get-LANDeskComputers which will only be computers with names
			starting with Pre-.
			
		.NOTES
			Still need to find documentation on what each return code means, specifically for the Reboot property.	
			
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[string]$GUID	
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
		$vulnerabilities = $LANDeskWebService.GetMachineVulnerabilities($Guid)
		$vulnerabilities.vulnerability | Where-Object {$_.Severity -notlike "Not Applicable"} | Sort-Object -Property Severity
	}
	End{}
}