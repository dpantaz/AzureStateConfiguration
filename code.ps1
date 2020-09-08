#Create new Automation Account
New-AzAutomationAccount -Name Automation1 -ResourceGroupName rg1 -Location westeurope

#Download sample DSC configuration that installs/removes IIS Server on Windows Server
Invoke-WebRequest -Uri https://raw.githubusercontent.com/dpantaz/AzureStateConfiguration/master/IISConfig.ps1 -OutFile IISConfig.ps1

#Import DSC configuration to Automation Accounts
Import-AzAutomationDscConfiguration -AutomationAccountName Automation1 -ResourceGroupName "rg1" -SourcePath ".\IISConfig.ps1" -Published

#Compile DSC configuration
Start-AzAutomationDscCompilationJob -ConfigurationName IISConfig -ResourceGroupName rg1 -AutomationAccountName Automation1

#Register Azure VM as DSC managed node
Register-AzAutomationDscNode -AutomationAccountName Automation1 -AzureVMName vm1 -ResourceGroupName rg1 -NodeConfigurationName "IISConfig.IsWebServer" -ConfigurationMode ApplyAndMonitor -RefreshFrequencyMins 30 -ConfigurationModeFrequencyMins 15