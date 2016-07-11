---
external help file: PsLANDesk-help.xml
online version: 
schema: 2.0.0
---

# Import-LANDeskInfoXMLReport
## SYNOPSIS
The Import-LANDeskInfoXMLReport function creates a PowerShell object from an exported LANDesk XML report.

## SYNTAX

```
Import-LANDeskInfoXMLReport [-Path] <String>
```

## DESCRIPTION
The Import-LANDeskInfoXMLReport function creates a PowerShell object from an exported LANDesk XML report.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Import-LANDeskInfoXMLReport -Path C:\Scripts\GFIRemaining.xml
```

Turns the xml report into a custom PowerShell object.

## PARAMETERS

### -Path
The file path to the exported LANDesk report.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

