# Docker Desktop Installer Wrapper - Windows 10

From the command line the Docker Desktop Installer waits for a user to hit return after the installation completes.  Wrapping
this command in ```Start-Process``` allows it to run to completion without blocking for user-input (which is ideal for automated installations).

**Waiting for User Input**
![Docker Desktop Setup Waiting](./images/desktop-docker-installer-waiting-for-user.png)

***Not*** **Waiting for User Input**
![Docker Desktop Setup Waiting](./images/desktop-docker-installer-not-waiting-for-user.png)

## PowerShell Script [`Invoke-DockerDesktopInstaller.ps1`](./Invoke-DockerDesktopInstaller.ps1)

The script in this repository invokes the ```Docker Desktop Installer.exe``` program and passes the return code from the executable to the calling process for ease of use w/automation.