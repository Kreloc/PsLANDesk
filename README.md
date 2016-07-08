PSLANDesk
==========

This is a PowerShell module for working with the LANDesk Console
Web based MBSDK.

#Instructions

```powershell
# One time setup
    # Download the repository
    # Unblock the zip
    # Extract the PSLANDesk folder to a module path (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)

    #Simple alternative, if you have PowerShell 5, or the PowerShellGet module:
        Install-Module PSLANDesk

# Import the module.
    Import-Module PSLANDesk    #Alternatively, Import-Module \\Path\To\PSLANDesk

# Get commands in the module
    Get-Command -Module PSLANDesk

# Get help
    Get-Help Connect-LANDeskServer -Full
```

#Examples

###Connect to LANDeskserver


```PowerShell
# Connects to landesk server in your environment using default credentials
	Connect-LANDeskServer -Server "YourServer"
```

###List all computers
```PowerShell
#Gets all of the computers available from the LANDesk server
	Get-LANDeskComputer

#Gets computer that matches filter
	Get-LANDeskComputer -Filter {$_.ComputerName -like "Pre-*"}
		
	Returns all LANDeskComputer objects that have a computername beginning with Pre-

```
