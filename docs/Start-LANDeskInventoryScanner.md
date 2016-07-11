---
external help file: PsLANDesk-help.xml
online version: 
schema: 2.0.0
---

# Start-LANDeskInventoryScanner
## SYNOPSIS
Start the LANDesk Inventory Scanner on remote computer.

## SYNTAX

```
Start-LANDeskInventoryScanner [-ComputerName] <String[]> [-WhatIf] [-Confirm]
```

## DESCRIPTION
Start the LANDesk Inventory Scanner on remote computer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```

```

Starts the Inventory scanner on the remote computer.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Content computers.txt | Get-Blank
```

Start the LANDesk Inventory Scanner on remote computer on each computer in the text file computers.txt

## PARAMETERS

### -ComputerName
The name of the target computer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
{{Fill WhatIf Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
{{Fill Confirm Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

