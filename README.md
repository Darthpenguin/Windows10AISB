# Windows 10 As It Should Be
This user guide will show you how to create a customized Windows 10 installation medium.

The goal of this project is to have a stripped-down version of Windows 10 that can be installed on any hardware. The finalized image should have a clean start menu with no tiles, be free of any superfluous software (bloatware), and have a clean taskbar and desktop.

## Section A: Download Windows 10 ISO
First, we need a copy of the Microsoft Windows 10 operating System.
1) Go to https://www.microsoft.com/en-ca/software-download/windows10 and grab the media creation tool.
![image](https://user-images.githubusercontent.com/3740366/168279519-7f180b01-a325-463a-88df-bc42ea57497a.png)
2) Launch the Media Creation Tool and read the Microsoft Software License Terms. Click **[Accept]** when ready.
3) Next, select “Create installation media (USB flash drive, DVD, or ISO file) for another PC”. Then click **[Next]**
![image](https://user-images.githubusercontent.com/3740366/168280811-ac44e393-6186-4a53-a204-2f0fab98c436.png)
4) At the next screen select your language, architecture, and edition. It's probably okay to accept the defaults here. Click **[Next]** when ready
5) We are going to be downloading the ISO file. Select "ISO File" then click **[Next]** (or press [Alt]+[N])
6) A dialog box will appear asking you where you want to save the ISO file. I recommend creating a project folder in the C:\ drive called Windows10AISB and saving the Windows.iso there.
7) You should see the progress indicator as the Media Creation Tool is downloading the ISO file. Go make some tea of coffee while you wait.

## Section B: Extract Files from the ISO
Second, we need to extract some files. An ISO is simply a type of archive (like a zip file or a 7z file). We need to extract the install.esd from the Windows.iso archive. We will be using the install.esd to create an answer file. I have already included an answer file in this repo. So you can save yourself some time by skipping this step and just using the answer file I provide (called unattend.xml). If you want to make your own then follow these steps.
1) If you do not already have 7-Zip installed on your computer head over to https://www.7-zip.org/ to download and install the 7-Zip.
2) Right-click on the Windows.iso that you downloaded in the previous section (located at C:\Windows10AISB\Windows.iso), select 7-Zip from the context menu, in the fly-out menu select "Open archive". An alternate method is to launch 7-Zip and navigate to C:\Windows10AISB and double-clicking on the Windows.iso file.
3) When the Windows.iso archive is open go to the "sources" folder and locate the "install.esd" file. Right-click the install.esd file and choose "Copy To..."
4) In the dialog box give it the path to your project folder. In our case the path is probably C:\Windows10AISB\ - Click **[ OK ]** to extract the file to the given path.

## Section C: Convert install.esd to WIM format
Unfortunately, we cannot work with the install.esd file as it is. Before we go any further we will need to create a WIM file. If you are not going to create your own answer file you can skip this step.
1) We need to decide which Windows SKU we are going to customize. In this example we are going to customize Windows 10 Pro
2) Right-click on your Windows 10 start menu and run "Command Prompt (Admin)" (or PowerShell as admin)
3) dism /Get-WimInfo /WimFile:C:\Windows10AISB\install.esd
4) Check the index number for Windows 10 Pro. In this case it looks like the index number is '6'
5) dism /export-image /SourceImageFile:C:\Windows10AISB\install.esd /SourceIndex:6 /DestinationImageFile:C:\Windows10AISB\install.wim /Compress:max /CheckIntegrity

## Section D: Install the Windows Assessment and Deployment Kit
Now we need to install the Windows Assessment and Deployment Kit. This is an absolute requirement for creating your own answer file AND it is required for creating a WindowsPE bootable flash drive which we will be using to capture an image from your reverence machine.
1) Go to https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install. Find and Download the "Windows ADK for Windows 10, version 2004" and the "Windows PE add-on for ADK, version 1903"
2) Install the adksetup.exe file first
3) We only need to select the Deployment Tools
4) Install the adkwinpesetup.exe. This can take a while as the installer will go out to the internet to acquire the the Windows Preinstallation Environment. Time for another cup of coffee.

## Section E: Creating the Answer File
This process looks very daunting at first, but we are just going to create a very simple answer file.
1) Launch the *Windows System Image Manager*.
2) Right-click on *Select a Windows image or catalog file* and *Select Windows Image...*
3) Select and open the image file which we extracted to C:\Windows10AISB\install.wim
4) A catalog file will need to be created. Click **[ Yes ]**. It might take a few minutes to create the catalog. Time for another coffee.
5) Select *File* > *New Answer File...*
6) In the **Windows Image** area, under *Components* look for *amd64_Microsoft-Windows-Setup_{Version Number}_neutral*. Expand that, right-click on UserData and add the setting to **Pass 1**
7) Next, right-click on *amd64_Microsoft-Windows-Shell-Setup_{Version Number}_neutral* and add it to **Pass 4**
8) Still under Components, expand *amd64_Microsoft-Windows-Shell-Setup{Version Number}_neutral*, right-click on *OOBE* and add the setting to **Pass 7**
9) Now in the **Answer File** area, in Pass 1 (windowsPE) under UserData we are going to set *AcceptEULA* to **true**
10) Under Pass 4 (specialize), set *CopyProfile* to **true**
11) In Pass 7 (oobeSystem) we have a few settings to configure:
    * *HideEULAPage* = **true**
    * *HideLocalAccountScreen* = **false**
    * *HideOEMRegistrationScreen* = **true**
    * *HideOnlineAccountScreens* = **true**
    * *HideWirelessSetuoInOOBE* = **true**
    * *SkipMachineOOBE* = **true**
    * *SkipUserOOBE* = **true**
12) Save the file answer file as Unattend.xml in our project folder at C:\Windows10AISB

## Section F: Create the WinPE ISO
Now we need to create a WinPE ISO file.
1) Start the DISM (Deployment and Imaging Tools Environment) Run as administrator.
2) copype amd64 C:\Windows10AISB\WinPE_amd64
3) MakeWinPEMedia /ISO C:\WinPE_amd64 C:\Windows10AISB\WinPE_amd64\WinPE_amd64.iso

## Section G: Install Windows on a Reference Machine | Writing the Windows.iso to a USB
Now that we have laid some of the ground work it is time to get down to brass tax. Actually customizing Windows 10. For our example we are going to use a spare laptop as a reference machine. If you are familiar with virtualisation (proxmox, vmware, hyper-v, virtualbox, etc.) you can defiantly create a new virtual machine to use as a reference system. Keep in mind that the point of creating the custom image in the first place is to change some personalization settings and capture our personalization settings as the new defaults. Some personalization settings cannot be changed unless Windows 10 is activated. Windows 10 typically activates automatically when installed on OEM hardware. If you are going to use a virtual machine you will want to be sure you have a valid licence key to activate Windows.
1) First, we need to grab the *Rufus* program from https://rufus.ie/en/. Download it and save it in C:\Windows10AISB
2) Grab a blank USB flash drive that is at least 16GB and connect it to your computer. Then run the rufus.exe program
3) In Rufus, select the Windows.iso file which was downloaded in Section A (it should be in C:\Windows10AISB).
4) Make sure the selected device is your 16GB USB flash drive.
5) When you are ready, click [START]. Wait for Rufus to write the ISO files to the USB. Time for yet another coffee.

## Section H: 
