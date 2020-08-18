<#
.SYNOPSIS
    Docker Desktop Installer CE PowerShell wrapper to allow quiet (no GUI) install to run to completion.
    *This installer (CE) is not supported by Mirantis.*
    
    *Requires elevation to run*
.DESCRIPTION
    The Community Edition (not supported by Mirantis) of the Docker Desktop Installer (was testing with 2.3.0.4)
    has (or had as it may be) a few undocumented command line install options which can be used for a quiet
    (non-interactive) installation.  However, when run from the command line the installation waits for user
    input (must hit return). This is not ideal for automated installations. This script simply calls the installer
    with Start-Process and the '-Wait' switch which (not exactly sure why) runs the installation to full completion
    (without blocking for someone to hit enter) and passes along the exit code of the installer the caller.
.PARAMETER Path
    Path to 'Docker Desktop Installer.exe'
.PARAMETER Action
    Specifies to run the 'Docker Desktop Installer.exe' w/either the install or uninstall argument
.PARAMETER Quiet
    Specifies to run the 'Docker Desktop Installer.exe' with the '--quiet' option (graphical interface suppressed)
.EXAMPLE
    .\Invoke-DockerDesktopInstaller.ps1 -Path 'C:\temp\Docker Desktop Installer.exe' -Action install -Quiet -Verbose
.NOTES
    Ryan Leap, Mirantis Support Engineer
    Docker Desktop Installer Community Edition is *not* supported by Mirantis
#>
[CmdletBinding()]
param (
    [ValidateScript({(Test-Path $_ -PathType Leaf) -and ((Split-Path -Path $_ -Leaf) -eq 'Docker Desktop Installer.exe')})]
    [string] $Path = (Join-Path -Path $PSScriptRoot -ChildPath 'Docker Desktop Installer.exe'),

    [ValidateSet('install','uninstall')]
    [string] $Action = 'install',

    [switch] $Quiet
)

#Requires -RunAsAdministrator

$ddiArgs = @($Action)
if ($Quiet) {
    $ddiArgs += '--quiet'
}
$procSplat = @{
    'FilePath'              = $Path
    'ArgumentList'          = $ddiArgs
    'Wait'                  = $true
}
Write-Verbose "Running [$Path] w/args [$ddiArgs]..."
$proc = Start-Process @procSplat -PassThru
Write-Verbose "Running [$Path] complete."
exit $proc.ExitCode