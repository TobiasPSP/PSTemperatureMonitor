function Start-MonitorTemperature
{
    <#
        .SYNOPSIS
        Continuously monitors all available temperature sensors. Requires Administrator privileges. Press CTRL+C to stop monitoring.

        .DESCRIPTION
        Uses the OpenHardwareMonitor library to continuously read all temperature sensors. Command refreshes values per second and calculates average temperature across all sensors.

        .EXAMPLE
        Start-MonitorTemperature
        Starts the temperature sensor monitoring. Press CTRL+C to stop monitoring.

        .EXAMPLE
        Start-MonitorTemperature -Interval 10 | Format-Table
        Starts the temperature sensor monitoring and refreshes every 10 seconds. Results are displayed as a table.
        Press CTRL+C to stop monitoring.

        .EXAMPLE
        Start-MonitorTemperature -Interval 5 | Out-GridView -Title 'Temperature Monitor'
        Starts the temperature sensor monitoring and refreshes every 5 seconds. Results are displayed in a separate GridView window.
        Press CTRL+C to stop monitoring.



    #>
    [CmdletBinding()]
    param
    (
        # Monitoring interval in seconds. Default is 1 second. When you specify 0, the results are returned, and no monitoring occurs.
        [ValidateRange(0,100000)]
        [int]
        $Interval=1
    )

Add-Type -Path "$PSScriptRoot\binaries\OpenHardwareMonitorLib.dll"

$isAdmin = ([Security.Principal.WindowsPrincipal] `
  [Security.Principal.WindowsIdentity]::GetCurrent() `
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!$isAdmin)
{
	Write-Warning 'You need to run with Administrator privileges in order to read hardware details.'
        return
}

    $HardwareMonitor = [OpenHardwareMonitor.Hardware.Computer]::new()
    $HardwareMonitor.CPUEnabled = $true
    $HardwareMonitor.HDDEnabled = $true

    $HardwareMonitor.Open()
    Write-Warning "HardwareMonitor opened."
    try
    {
   
        do
        {
            $HardwareMonitor.Hardware.Update()
            $result = [Ordered]@{
                Time = Get-Date -Format HH:mm:ss
            }
            $numberSensors = 0
            $sumTemperature = 0
            $HardwareMonitor.Hardware.Sensors | 
            Where-Object SensorType -eq Temperature |
            ForEach-Object {
                $numberSensors++
                $sumTemperature+=$_.Value -as [int]
                $name = '{0} {1}' -f $_.Hardware.HardwareType, $_.Name.Replace($_.Hardware.HardwareType.ToString(),'').Trim()
                $result[$name] = $_.Value -as [int]
            }
            $result['Average'] = ($sumTemperature/$numberSensors) -as [int]
            [PSCustomObject]$result
        
            Start-Sleep -Seconds $Interval
        } while ($true -and ($interval -ne 0))
    
    }
    finally
    {
        $HardwareMonitor.Close()
        Write-Warning "HardwareMonitor closed."
    }
}