Function Get-LANDeskMachineData
{
	<#	
		.SYNOPSIS
			Retrieves more detailed information about the computer specified by the GUID parameter from the LANDeskWebService object.
		
		.DESCRIPTION
			Retrieves more detailed information about the computer specified by the GUID parameter.
		
		.PARAMETER GUID
			The GUID of the LANDeskComputer to obtain Machine Data for from the LANDesk WebService.

		.EXAMPLE
			$LANDeskComputers | Where {$_.ComputerName -eq "THATPC"} | Get-LANDeskMachineData -ColumnSetName "Mark"
			
			Returns machine information on the the computer named THATPC. Will return all of the information viewable from the Columns set
			Mark.
			
		.EXAMPLE
			$results = Get-LANDeskComputer -Filter {$_.ComputerName -like "ns-ldp*"} | Get-LANDeskMachineData -ColumnSetName "Other"
		
			Pipes the GUIDs of all the computers with a name beginning with ns-ldp into the function and
			Stores the results of the GetMachineDataEX method call using the column setnamed Other into the variable named $results.
				
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[string]$GUID,
        [Parameter(Mandatory=$False,ValueFromPipelinebyPropertyName=$true)]
		[string]$ColumnSetName = "Mark"
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
        Write-Verbose "Getting Machinedata for computer with GUID of $Guid"
    	$MachineData = $LANDeskWebService.GetMachineDataEX("$Guid","$ColumnSetName")
		$MachineData = $MachineData.Computer
		#Below is unique data for my columnSetName named Mark
		If($ColumnSetName -eq "Mark")
		{
            Write-Verbose "Getting machine data with colum set Mark"
            $Model = $MachineData.System.Model
			$SID = $MachineData.CustomData.Registry.LANDeskCustomFields.SID
			$SerialNumber = $MachineData.BIOS.SerialNumber
            $IPAddress = $MachineData.Network.TCPIP.Address
			#$InstalledSoftware = ($MachineData.Software.AddorRemovePrograms.Program | Select -ExpandProperty Name) -join ";"
			$ComputerName = $MachineData.DisplayName
            Write-Verbose "Attempting to get drive space for $ComputerName"
            $LogicalDriveObj = $MachineData.MassStorage.LogicalDrive | Where {$_.DriveLetter -like "C"}
            If($LogicalDriveObj)
            {
                Write-Verbose "Getting drive space information for $ComputerName"
                $DriveLetter = $LogicalDriveObj.DriveLetter
                $AvailableStorage = $LogicalDriveObj.AvailableStorage
                $TotalStorage = $LogicalDriveObj.TotalStorage
                $PercentFree = ([Math]::Round(($AvailableStorage / $TotalStorage)*100))
            }
            else
            {
                Write-Verbose "Could not get drive space information for $ComputerName"
                $DriveLetter = "NA"
                $AvailableStorage = "NA"
                $TotalStorage = "NA"
                $PercentFree = "NA"
            }
			$MachineData | Select-Object @{name="ComputerName";expression={$ComputerName}}, LastUpdateScanDate, LastSoftwareScanDate, @{name="SID";expression={$SID}}, @{name="SerialNumber";expression={$SerialNumber}},
			Description, PrimaryOwner, @{name="IPAddress";expression={$IPAddress}}, @{name="Model";expression={$Model}}, @{name="DriveLetter";e={$DriveLetter}}, @{name="PercentFreeSpace";e={$PercentFree}},@{name="TotalDriveSize";expression={$TotalStorage}}, @{name="FreeDriveSpace";expression={$AvailableStorage}}
		}
		else
		{
			#$MachineData
            $ColumnResults = Get-LANDeskColumnSetColumns -Name $ColumnSetName
            $Columns = (($ColumnResults.Columns -replace '"Computer".') -replace '"') -replace " "
            $propNames=$Columns -replace '\.'

            $EndResults = New-Object –TypeName PSObject
            #$MachineData.
            $i = 0
            Do
            {
                $value = $null
                Write-Verbose "Adding $($Columns[$i]) to value variable"
                $valueProp = "$($Columns[$i])"
                Write-Verbose "$MachineData.$($valueProp) being added"
                $value = $MachineData.$($Valueprop)
                Write-Verbose "Adding value: $value to object"
                $EndResults | Add-Member -MemberType NoteProperty -Name $propNames[$i] -Value $value
                $i++
            }
            Until($i -eq $Columns.Count)
            $EndResults


		}
	}
}