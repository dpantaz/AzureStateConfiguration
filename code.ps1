New-AzAutomationAccount -Name Automation1 -ResourceGroupName rg1 -Location westeurope

Invoke-WebRequest -Uri https://raw.githubusercontent.com/dpantaz/AzureStateConfiguration/master/TestConfig.ps1 -OutFile TestConfig.ps1

Import-AzAutomationDscConfiguration -AutomationAccountName "Automation1" -ResourceGroupName "rg1" -SourcePath ".\TestConfig.ps1" -Published

Start-AzAutomationDscCompilationJob -ConfigurationName TestConfig -ResourceGroupName rg1 -AutomationAccountName automation1

Register-AzAutomationDscNode -AutomationAccountName automation1 -AzureVMName vm1 -ResourceGroupName rg1 -NodeConfigurationName "TestConfig.IsWebServer" -ConfigurationMode ApplyAndAutocorrect -RefreshFrequencyMins 30 -ConfigurationModeFrequencyMins 15