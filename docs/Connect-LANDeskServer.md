---
external help file: PsLANDesk-help.xml
online version: 
schema: 2.0.0
---

# Connect-LANDeskServer
## SYNOPSIS
Connects to the webservice of inputted LANDesk server.

## SYNTAX

```
Connect-LANDeskServer [[-LANDeskServer] <String>]
```

## DESCRIPTION
Connects to the webservice of inputted LANDesk server.
Creates a global variable for use in the PSLANDesk Module.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Connect-LANDeskServer -LANDeskServer "LDServer"
```

Connects to the LDServer.
It then verifies the rights you have on that server.

## PARAMETERS

### -LANDeskServer
The name of the LANDesk server to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Avjnu00
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

