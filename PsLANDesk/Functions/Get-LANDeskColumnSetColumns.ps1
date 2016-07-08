Function Get-LANDeskColumnSetColumns 
{
	<#	
		.SYNOPSIS
			The Get-LANDeskColumnSetColumns function returns a list of available Column sets.
		
		.DESCRIPTION
			The Get-LANDeskColumnSetColumns function returns a list of available Column sets. This can be used to determine the columns available to each set.
		
		.PARAMETER Name
			The Name of the ColumnSet to retrieve the columns from.

		.EXAMPLE
			Get-LANDeskColumnSetColumns -ColumnSetName "Mark"
			
			Returns a list of available columns in the column set named Mark.
						
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipelinebyPropertyName=$true)]
		[alias("ColumnSetName")]
		[string]$Name
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
        $props = @{
                   ColumnSetName=$Name
                   Columns=$LANDeskWebService.ListColumnSetColumns($Name).Columns
        }
		New-Object -TypeName psobject -Property $props
	}
	End{}
}
