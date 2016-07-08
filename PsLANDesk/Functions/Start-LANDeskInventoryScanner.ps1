Function Start-LANDeskInventoryScanner
{
	<#	
		.SYNOPSIS
			Start the LANDesk Inventory Scanner on remote computer.
		
		.DESCRIPTION
			Start the LANDesk Inventory Scanner on remote computer.
		
		.PARAMETER ComputerName
			The name of the target computer.
			
		.EXAMPLE
			Start-LANDeskInventoryScanner -ComputerName <ComputerName>
			
			Starts the Inventory scanner on the remote computer.
			
		.EXAMPLE
			Get-Content computers.txt | Get-Blank
		
			Start the LANDesk Inventory Scanner on remote computer on each computer in the text file computers.txt		
			
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
        $CoreServer = "avjnu00"
    }
	Process 
	{
        $EndResults = @()
        ForEach($Computer in $ComputerName)
        {
        If(Test-Connection -ComputerName $Computer -Quiet -Count 1)
        {
                $Command = '"C:\Program Files (x86)\Landesk\LDClient\LDISCN32.EXE"  /NTT=$CoreServer:5007 /S="$CoreServer" /NOUI /SYNC'
                If($PSCmdlet.ShouldProcess("$Computer","Starting landesk Inventory scan process"))
                {
                    $returnval = ([WMICLASS]"\\$computer\ROOT\CIMV2:win32_process").Create($Command)
                    If($returnval.ReturnValue -eq 0)
                    {
                        $returnval = "Running"
                    }
                    else
                    {
                        $returnval = "Error"
                    }
                }
                $Online = $True
            }
            else
            {
                $returnval = "Error"
                $Online = $False
            }
            $props = @{ComputerName=$Computer
                        Online=$Online
                        ScanStatus=$returnval
                        }
            $EndResults += New-Object -TypeName psobject -Property $props
        }
        If($PSCmdlet.ShouldProcess("$Computer","Outputting run result object"))
        {
            $EndResults
        }
    }
}