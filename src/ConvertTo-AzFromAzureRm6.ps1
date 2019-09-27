<#
.SYNOPSIS
  A PowerShell script to convert a directory and all sub directories from AzureRM 6 to Az PowerShell.

.DESCRIPTION
  A PowerShell script to convert a directory and all sub directories from AzureRM 6 to Az PowerShell.

.PARAMETER FileName
  A string match file names. Wildcarding is supported.

.PARAMETER RootDirectory
  The root directory to start the conversion from.

.PARAMETER CustomMappings
  Optional: Any custom mappings in code that you want to be converted. This parameter type is a Hashtable.

.EXAMPLE
  .\ConvertTo-AzFromAzureRm6.ps1 -RootDirectory 'S:\SourceCode\myrepo'
  .\ConvertTo-AzFromAzureRm6.ps1 -RootDirectory 'S:\SourceCode\myrepo' -FileName '.ps1'
  .\ConvertTo-AzFromAzureRm6.ps1 -RootDirectory 'S:\SourceCode\myrepo' -CustomMappings @{ "testAzureRm6" = "testAz" }
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $false)]
  [String] $FileName,

  [Parameter(Mandatory = $true)]
  [ValidateScript( {
      if ( -Not ($_ | Test-Path) )
      {
        throw "File or folder does not exist"
      }
      return $true
    })]
  [String] $RootDirectory,

  [Parameter(Mandatory = $false)]
  [System.Collections.Hashtable] $CustomMappings = @{ }
)

Set-Location -Path $RootDirectory

$items = Get-ChildItem "$RootDirectory\*" -Exclude @('*.exe', '*.json') -Recurse -Depth 100 | Where-Object { !$_.PSisContainer }
$azureMappings = ((Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/azure-powershell/master/src/Accounts/Accounts/AzureRmAlias/Mappings.json -UseBasicParsing).Content | ConvertFrom-Json)

$customMappingsAsObject = [PSCustomObject]$CustomMappings

if ($FileName) {
  $items = $items | Where-Object { $($_.Name) -match $FileName }
}

foreach ($item in $items)
{
  $fullPathFileName = $item.FullName
  $fileContents = (Get-Content $fullPathFileName -Raw)

  Write-Host "Processing file $fullPathFileName"

  $fileTouched = $false

  ($azureMappings | Get-Member -MemberType NoteProperty) | ForEach-Object {
    $azureMappings.$($_.Name) | ForEach-Object {
      foreach ($Mapping in ($_ | Get-Member -MemberType NoteProperty))
      {
        if (-not $fileTouched)
        {
          $fileTouched = $fileContents -match $_.$($Mapping.Name)
        }

        $fileContents = $fileContents -replace $_.$($Mapping.Name), $Mapping.Name
      }
    }
  }

  ($customMappingsAsObject | Get-Member -MemberType NoteProperty) | ForEach-Object {
    $name = [regex]::Escape($($_.Name))
    $valueToReplace = $customMappingsAsObject.$($_.Name)
    if (-not $fileTouched)
    {
      $fileTouched = $fileContents -match $name
    }

    $fileContents = $fileContents -replace $name, $valueToReplace
  }

  if ($fileTouched)
  {
    $fileContents | Set-Content $fullPathFileName -NoNewline
    Write-Host "Saved file $fullPathFileName"
  }
}