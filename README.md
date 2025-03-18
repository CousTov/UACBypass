# Fodhelper UAC Bypass Implementation

## Overview
This repository contains a PowerShell script that demonstrates a UAC (User Account Control) bypass using **Fodhelper.exe**, a trusted binary in Windows operating systems. By exploiting a feature of Fodhelper.exe, we can elevate privileges without triggering the typical UAC prompt, allowing for seamless execution of elevated commands.

### What is Fodhelper.exe?
**Fodhelper.exe** is a trusted system binary found in Windows operating systems, specifically designed for managing system settings. By default, this executable has administrative privileges and is considered a "trusted binary" in Windows. As a result, **Fodhelper.exe** can be leveraged to gain administrative rights without triggering the standard UAC prompt that usually appears when attempting to run applications as an administrator.

In simpler terms, when running an application that requires administrative privileges, Windows typically prompts the user to confirm the action (UAC prompt). However, **Fodhelper.exe** bypasses this step, allowing for elevated privileges without user intervention. This behavior is a Windows-specific feature that can be exploited through registry manipulation to stealthily execute commands with administrative rights.

### How Does it Work?
The process involves manipulating registry entries related to **Fodhelper.exe** to invoke the binary with elevated privileges. Once triggered, **Fodhelper.exe** will execute the designated commands, such as running PowerShell scripts, with administrator rights.

This technique allows for the execution of commands or scripts that would typically require UAC confirmation, bypassing the prompt altogether. It can be used for automation or stealthy privilege escalation purposes.

### Stripped-Down Script
This repository provides a **stripped-down version of the PowerShell script** that showcases the basic functionality of the Fodhelper UAC bypass technique. The script is simplified to demonstrate that the method works, and you can modify it as needed to suit your purposes. **Please note**: This tool is intended for educational purposes only and should be used responsibly.

### Legal Disclaimer
This script and method are shared for educational purposes only. Misuse of this information, including unauthorized access to systems or data, is illegal and unethical. Always obtain proper authorization before attempting to use this technique in any environment. The author of this repository assumes no responsibility for any consequences arising from the use of this tool.

---

## Usage

### Prerequisites
- A Windows operating system with UAC enabled (the method works by exploiting **Fodhelper.exe**'s behavior in these environments).
- Administrative privileges are needed to manipulate the system registry.
- PowerShell is required for executing the script.

### Running the Script
1. Download or clone the repository.
2. Open a PowerShell session with administrative privileges.
3. Navigate to the directory where the script is located.
4. Execute the PowerShell script using the following command:
   ```powershell
   .\uacGit.ps1

