#####################################################################
# Script de Bootstrap para servidores Windows						#
# Desenvolvido por Filipe Caló										#
#####################################################################

echo "###################################################################"
echo "#																	#"
echo "#						KEEP IT SIMPLE								#"
echo "#																	#"
echo "###################################################################"

echo "-----------------------------------"
echo "Bootstrap Server 2012 R2"
echo "-----------------------------------"

Set-ExecutionPolicy RemoteSigned -Force
function Disable-IEESC
{
	$AdminKey = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}”
	$UserKey = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}”
	Set-ItemProperty -Path $AdminKey -Name “IsInstalled” -Value 0
	Set-ItemProperty -Path $UserKey -Name “IsInstalled” -Value 0
	Stop-Process -Name Explorer
	Write-Host “IE Enhanced Security Configuration (ESC) has been disabled.” -ForegroundColor Green
}
Disable-IEESC
#	echo "----------------------------------"
#	echo "Seting Background Information"
#	echo "----------------------------------"
#	Bginfo.exe C:\Windows\default\background.bgi /timer 0 /silent /accepteula
echo "----------------------------------"
echo "Enable Remote Desktop"
echo "----------------------------------"
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1 
Get-NetFirewallProfile | Set-NetFirewallProfile -Enabled False
([adsi]“WinNT://localhost/Administrator”).SetPassword(“P@ssw0rd”)