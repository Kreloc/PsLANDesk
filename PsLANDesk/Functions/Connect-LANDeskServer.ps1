Function Connect-LANDeskServer
{
	<#	
		.SYNOPSIS
			Connects to the webservice of inputted LANDesk server.
		
		.DESCRIPTION
			Connects to the webservice of inputted LANDesk server. Creates a global variable named $LANDeskWebService for use in the PSLANDesk Module.
		
		.PARAMETER LANDeskServer
			The name of the LANDesk server to connect to.

		.EXAMPLE
			Connect-LANDeskServer -LANDeskServer "LDServer"
			
			Connects to the LDServer using the current users credentials. It then verifies that the user has permissions on the LANDeskserver.

        .EXAMPLE
            Connect-LANDeskServer -LANDeskSever "LDServer" -Credential

            Connects to the LDServer prompting for credentials to be used. It then verifies that the user has permissions on the LANDeskserver.


        .NOTE
            This needs to be run before any other function from this module will work.
			
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[string]$LANDeskServer,
        [switch]$Credential
	)
	Begin{}
	Process
	{
        If($Credential)
        {
           $global:LANDeskWebService = New-WebServiceProxy -uri http://$LANDeskServer/MBSDKService/MsgSDK.asmx?WSDL -Credential (Get-Credential)
            $Rights = $LANDeskWebService.ResolveScopeRights()
            If(!($Rights))
            {
                Write-Error "User account used does not have sufficient permissions on $($LANDeskServer)"
            }
        }
        else
        {
            Write-Verbose -Message "Connecting to LANDesk"
		    $global:LANDeskWebService = New-WebServiceProxy -uri http://$LANDeskServer/MBSDKService/MsgSDK.asmx?WSDL -UseDefaultCredential
		    Write-Verbose -Message "Resolving rights"
            $Rights = $LANDeskWebService.ResolveScopeRights()
            If(!($Rights))
            {
                Write-Error "User account used does not have sufficient permissions on $($LANDeskServer)"
            }
        }
	}
	End{}
}