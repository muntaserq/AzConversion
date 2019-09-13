# AzConversion
A utility to convert from AzureRM 6 to Az PowerShell

## Getting Started

This script converts all scripts given a root directory from AzureRM 6 to Az PowerShell using mappings provided by Azure PowerShell's Github repo. The only thing this script does not take into consideration is breaking changes. Breaking changes must be analyzed per code base. You can read up on breaking changes to Az by navigating to the [Breaking changes for Az 1.0.0](https://docs.microsoft.com/en-us/powershell/azure/migrate-az-1.0.0?view=azps-2.6.0) document.

Reminder: Be sure to always test your code after making these changes!

### Prerequisites

PowerShell

## Deployment

The script to convert from AzureRM 6 to Az is easy to execute. It uses mappings from Azure's Github site and converts an entire directory and everything under it to Az PowerShell using those mappings.

```
S:\SourceCode\AzConversion\src\ConvertTo-AzFromAzureRm6.ps1 -RootDirectory S:\SourceCode\myrepo
S:\SourceCode\AzConversion\src\ConvertTo-AzFromAzureRm6.ps1 -RootDirectory S:\SourceCode\myrepo -CustomMappings @{ "mapthis" = "toThis" }
```

## Built With

* [PowerShell 5.1](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-5.1) - PowerShell 5.1

## Authors

* **Muntaser Qutub** - *Initial work* - [PurpleBooth](https://github.com/muntaserq)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details