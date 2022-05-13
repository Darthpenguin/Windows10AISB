# Windows 10 As It Should Be
This user guide will show you how to create a customized Windows 10 installation medium.

The goal of this project is to have a stripped-down version of Windows 10 that can be installed on any hardware. The finalized image should have a clean start menu with no tiles, be free of any superfluous software (bloatware), and have a clean taskbar and desktop.

##Section A: Download Windows 10 ISO
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

##Section B: Extract Files from the ISO
Second, we need to extract some files. An ISO is simply a type of archive (like a zip file or a 7z file). We need to extract the install.esd from the Windows.iso archive.
We will be using the install.esd to create an answer file. I have already included an answer file in this repo. So you can save yourself some time by skipping this step and just using the answer file I provide. If you want to make your own then follow these steps.
1) If you do not already have 7-Zip installed on your computer head over to https://www.7-zip.org/ to download and install the 7-Zip.
2) Right-click on the Windows.iso that you downloaded in the previous section (located at C:\Windows10AISB\Windows.iso), select 7-Zip from the context menu, in the fly-out menu select "Open archive". An alternate method is to launch 7-Zip and navigate to C:\Windows10AISB and double-clicking on the Windows.iso file.
3) When the Windows.iso archive is open go to the "sources" folder and locate the "install.esd" file. Right-click the install.esd file and choose "Copy To..."
4) In the dialog box give it the path to your project folder. In our case the path is probably C:\Windows10AISB\ - Click **[ OK ]** to extract the file to the given path.

