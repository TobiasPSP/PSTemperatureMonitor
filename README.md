# PSTemperatureMonitor

This module provides an easy-to-use cmdlet to monitor physical hardware temperature.

## Download and Install

So if your notebook van is making noises, or you'd like to check your server health, simply install this module from the PowerShell Gallery:

```powershell
Install-Module -Name PSTemperatureMonitor -Scope CurrentUser
```

> Temperature can only be read by users with local Administrator privileges. So when you download and install this module, make sure it is accessible to the user that later is used to run the cmdlets.
> If you are not *elevating the same user* that installed the module, you may want to omit `-Scope CurrentUser` and instead install the module for *All Users*


## Monitor

