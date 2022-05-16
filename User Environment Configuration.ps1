<#
Script Name:    User Environment Configuration.ps1
Description:    This script is will execute a number of registry tweaks for the current user
Author:         Jeff Paxton
Email:          jpaxton@brokerlink.ca
#>
$ErrorActionPreference = 'SilentlyContinue'

#set registry value function
function TweakReg {
IF(!(Test-Path $registryPath))
 {
  New-Item -Path $registryPath -Force | Out-Null
  New-ItemProperty -Path $registryPath -Name $name -Type $type -Value $value -Force| Out-Null
 } ELSE {
  Set-ItemProperty -Path $registryPath -Name $name -Type $type -Value $value -Force | Out-Null
}}

#apply system dark theme
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$name = "AppsUseLightTheme"
$type = "DWORD"
$value = "0" 
TweakReg

#hide synaptics touchpad system tray icon
$registryPath = "HKCU:\Software\Synaptics\SynTPEnh"
$name = "TrayIcon"
$type = "DWORD"
$value = "33" 
TweakReg

#hide taskbar search box
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
$name = "SearchboxTaskbarMode"
$type = "DWORD"
$value = "0" 
TweakReg

#hide taskview button from taskbar
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "ShowTaskViewButton"
$type = "DWORD"
$value = "0"
TweakReg

#never combine taskbar buttons on primary taskbar
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "TaskbarGlomLevel"
$type = "DWORD"
$value = "2"
TweakReg

#never combine taskbar buttons on all secondary displays
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "MMTaskbarGlomLevel"
$type = "DWORD"
$value = "2"
TweakReg 

#always show all icons in the system tray
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
$name = "EnableAutoTray"
$type = "DWORD"
$value = "0"
TweakReg

#remove recyclebin from the desktop (option 1)
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$name = "{645FF040-5081-101B-9F08-00AA002F954E}"
$type = "DWORD"
$value = "1"
TweakReg 

#remove recyclebin from the desktop (option 2)
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"
$name = "{645FF040-5081-101B-9F08-00AA002F954E}"
$type = "DWORD"
$value = "1"
TweakReg

#remove the intel graphics driver icon from the system tray
$registryPath = "HKCU:\SOFTWARE\Intel\Display\igfxcui\igfxtray\TrayIcon"
$name = "ShowTrayIcon"
$type = "DWORD"
$value = "0"
TweakReg

#Lauching Windows Explorer goes to the 'This PC' location by default
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "LaunchTo"
$type = "DWORD"
$value = "1"
TweakReg

#show file extensions for known file types in Windows Explorer
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "HideFileExt"
$type = "DWORD"
$value = "0"
TweakReg

#swap powershell for cmd in the start button right-click menu
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "DontUsePowerShellOnWinX"
$type = "DWORD"
$value = "1"
TweakReg

#hide the Cortana button from the taskbar
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "ShowCortanaButton"
$type = "DWORD"
$value = "0"
TweakReg

#auto arrange icons on the desktop and align to grid
$registryPath = "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop"
$name = "FFLAGS"
$type = "DWORD"
$value = "1075839525"
TweakReg

#disable news and interests on taskbar
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
$name = "ShellFeedsTaskbarViewMode"
$type = "DWORD"
$value = "2" 
TweakReg

#disable quick access in explorer navigation pane
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
$name = "HubMode"
$type = "DWORD"
$value = "1"
TweakReg

#disable 'show recently used files in quick access'
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
$name = "ShowRecent"
$type = "DWORD"
$value = "0"
TweakReg

#disable 'show recently opened items in jump lists on start or the taskbar'
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$name = "Start_TrackDocs"
$type = "DWORD"
$value = "0"
TweakReg

stop-process -name explorer -force

#############################################
## So long and thanks for all the fish.  ####
#############################################