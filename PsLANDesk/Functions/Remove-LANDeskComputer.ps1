Function Remove-LANDeskComputer
{
	<#	
		.SYNOPSIS
			Removes specified computer from LANDesk.
		
		.DESCRIPTION
			Removes specified computer from LANDesk.
		
		.PARAMETER ComputerName
			The name or names of the computers to remove from the LANDesk database.
		
		.EXAMPLE
			Remove-LANDeskComputer <ComputerName>
			
			Removes the computer specified for ComputerName.
        
        .EXAMPLE
            Remove-LANDesk -ComputerName "THATPC" -WhatIf

            Removes the computer named THATPC but doesn't perform the action, instead displaying the WhatIf message.
			
		.EXAMPLE
			Get-Content computers.txt | Remove-LANDeskComputer
		
			Remove each computername listed on each line of computers.txt
			
	#>
	[CmdletBinding(SupportsShouldProcess=$true)]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[string[]]$ComputerName	
	)
	Begin
	{
		If(!($LANDeskWebService))
		{
			Write-Warning -Message "An active connection to the LANDesk Web Service was not found. Please run Connect-LANDeskServer before any other functions."
        }
    }
    Process
    {
        ForEach($Computer in $ComputerName)
        {
            $FoundComputer = Get-LANDeskComputer -Identity $Computer
            If($FoundComputer)
            {
                Write-Verbose "Attempting to delete computer $($Computer)"
                $Guid = $FoundComputer.GUID
                If($PSCmdlet.ShouldProcess("$Computer","Performing delete operation"))
                {
                    $LANDeskWebService.DeleteComputerByGUID("$GUID")
                }
            }
            else
            {
                Write-Warning "Did not find computer $($computer)"
                Continue
            }
        }
    }
    End{}
}