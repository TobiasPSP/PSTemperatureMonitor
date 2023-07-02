
# use this file to define global variables on module scope
# or perform other initialization procedures.
# this file will not be touched when new functions are exported to
# this module.


Add-Type -Path "$PSScriptRoot\binaries\OpenHardwareMonitorLib.dll"

$isAdmin = ([Security.Principal.WindowsPrincipal] `
  [Security.Principal.WindowsIdentity]::GetCurrent() `
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!$isAdmin)
{
	Write-Warning 'You need to run with Administrator privileges in order to read hardware details.'
}
