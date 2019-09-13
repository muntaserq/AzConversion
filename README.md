# AzConversion
A utility to convert from AzureRM 6 to Az PowerShell

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

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