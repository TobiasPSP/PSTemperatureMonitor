# PSTemperatureMonitor

This module provides an easy-to-use cmdlet to monitor physical hardware temperature.

> The actual logic for reading and evaluating hardware temperature data is performed by an open-source DLL gathered from https://openhardwaremonitor.org/.
> Basically, the *OpenHardwareMonitor* is a *DLL* plus a GUI that can be used to investigate your hardware, including temperature sensors. The DLL is doing the actual work, and this module shows how *you* can use the DLL and query it via PowerShell for whatever hardware information you are after.

There are a few PowerShell modules that do similar things however all others that I tried rely on outdated and limited resources. They can only query a limited number of temperature sensors.

This module is using the latest library and can query temperature readings from a wide range of CPUs and also from many harddrives. So chances are best to be able to use at least one supported temperature sensor in your hardware.


## Download and Install

So if your notebook van is making noises, or you'd like to check your server health, simply install this module from the PowerShell Gallery:

```powershell
Install-Module -Name PSTemperatureMonitor -Scope CurrentUser
```

> Temperature can only be read by users with local Administrator privileges. So when you download and install this module, make sure it is accessible to the user that later is used to run the cmdlets.
> If you are not *elevating the same user* that installed the module, you may want to omit `-Scope CurrentUser` and instead install the module for *All Users*


## Monitor

> Reading hardware information requires local *Administrator* privileges!

To start a continuous monitoring, use `Start-MonitorTemperature -Interval 5`. This will update the readings every 5 seconds.
To format the results as a table, you may want to run this code:

```powershell
Start-MonitorTemperature -Interval 5 | Format-Table -Wrap
```
