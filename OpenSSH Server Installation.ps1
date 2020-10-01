# Script created by Jordan Lydon
# https://turnthelydon.com
# https://github.com/TurnTheLydon/OpenSSHWS

Write-Host 'Checking for OpenSSH Availability and Installation Status'

Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

$confirmation = Read-Host 'Would you like to install OpenSSH Server? y/n'

if ($confirmation -eq 'y') {
Write-Host 'Installing OpenSSH Server'
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
}
if ($confirmation -eq 'n') {
Write-Host 'Cancelling Installation'
}
Set-Service -Name sshd -StartupType Automatic
Get-NetFirewallRule -Name *ssh*
$sshconfirm = Read-Host 'If there is not a firewall rule shown, please enter y, if a rule is shown enter n'
if ($sshconfirm -eq 'y') {
Write-Host 'Creating Firewall Rule'
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
Start-Service sshd
}
if ($sshconfirm -eq 'n') {
Write-Host 'Starting OpenSSH Server Service'
Start-Service sshd
}
Write-Host 'OpenSSH Server installation completed'