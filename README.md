# Lenovo K8 Plus Root Guide

This guide will walk you through the process of rooting your **Lenovo K8 Plus**. Make sure you follow every step carefully to avoid any issues. Rooting will give you full access to your device and allow for further customization, but keep in mind that it **voids the warranty**.

## Table of Contents

1. [Overview](#overview)
2. [Pre-Requisites](#pre-requisites)
3. [Backup Your Data](#backup-your-data)
4. [Rooting Instructions](#rooting-instructions)
   - [Enable Developer Options and USB Debugging](#enable-developer-options-and-usb-debugging)
   - [Install ADB on Your PC](#install-adb-on-your-pc)
   - [Unlock Bootloader](#unlock-bootloader)
   - [Install TWRP Recovery](#install-twrp-recovery)
   - [Root Using Magisk](#root-using-magisk)
   - [GSI rom install](#GSI-rom-install)
5. [Troubleshooting](#troubleshooting)
6. [FAQ](#faq)
7. [Contributing](#contributing)
8. [License](#license)
9. [Credits](#credits)

## Overview

Rooting your **Lenovo K8 Plus** will give you full control over your device. This includes removing pre-installed apps, installing custom ROMs, and gaining access to root-only features. The process requires unlocking the bootloader, installing TWRP, and using **Magisk** to root the device. Please ensure that you back up your data and follow the steps carefully.

## Pre-Requisites

Before starting, ensure that you have the following:

- **Lenovo K8 Plus** with at least 50% battery.
- A **PC (Windows, Linux, or macOS)**.
- USB cable to connect your phone to your PC.
- **[ADB drivers]()** installed on your PC.
- USB Debugging enabled on your device. Follow the steps below to enable it.
- **TWRP** and **Magisk.zip** files downloaded on your device.

### Required Downloads:

- **[TWRP for Lenovo K8 Plus]()**
- **[Magisk.zip]()**
- **[ADB and Fastboot tools]()**

## Backup Your Data

Before you begin, it's highly recommended to back up all your important data. Rooting your phone can result in data loss, so it’s essential to make sure you’ve saved everything important.

- **Google Backup**: Use **Google Drive**to back up your contacts, app data, and settings.
- **TWRP Backup**: You can also perform a full using TWRP to back up the entire system image.

## Rooting Instructions

### 1. Enable Developer Options and USB Debugging

First, enable Developer Options on your Lenovo K8 Plus:

1. Go to **Settings** on your phone.
2. Scroll down and tap **About phone**.
3. Tap **Build number** 7 times until you see a message saying that **Developer Options** are enabled.
4. Go back to the **Settings** menu and tap **Developer options**.
5. Enable **USB debugging** and **OEM unlocking**.

### 2. Install ADB on Your PC

Now you need to install **ADB** (Android Debug Bridge) on your PC:

1. Download the **[ADB and Fastboot tools]()**.
2. Extract the files and install them on your computer.
3. Once installed, you’ll use ADB to interact with your phone via command line.

### 3. Unlock Bootloader

Now, unlock the bootloader of your Lenovo K8 Plus. **Note:** Unlocking the bootloader will wipe all data from your phone, so ensure you’ve backed up everything.

1. Open **Settings > Developer options** on your phone.
2. Enable **OEM Unlocking**.
3. Connect your phone to your computer via USB cable.
4. Open a **Command Prompt** on your PC (or **Terminal** on macOS/Linux) and navigate to the folder where ADB is installed.
5. Type the following command to ensure your device is connected:

   ```bash
   adb devices
   ```

   You should see an output like this:

   ```
   List of devices attached
   xxxxxxxxxxxxxxxx device
   ```

6. If you see the output above, type the following to reboot your phone into fastboot mode:

   ```bash
   adb reboot bootloader
   ```

   Your phone will go blank, and you'll see some small text in the corner or middle-left of the screen.

7. Now unlock the bootloader by typing the following:

   ```bash
   fastboot oem unlock
   ```

8. After this, your phone will reset to factory settings.

### 4. Install TWRP Recovery

1. Download the **TWRP recovery image** for Lenovo K8 Plus and place it in a folder on your PC.
2. Open a **Command Prompt** (or **Terminal**) in that folder (you can do this by clicking the address bar in Windows Explorer and typing `cmd`).
3. Type the following command to check if your device is connected in fastboot mode:

   ```bash
   fastboot devices
   ```

   You should see something like this:

   ```
   xxxxxxxxxxxxxxxx fastboot
   ```

4. Flash the TWRP recovery image with the following command:

   ```bash
   fastboot flash recovery twrp.img
   ```

   You’ll see an output like this:

   ```
   Sending 'recovery' (15024 KB) OKAY [0.640s]
   Writing 'recovery' OKAY [0.248s]
   ```

5. After the flash is complete, type:

   ```bash
   fastboot reboot
   ```

   Your phone will now reboot back into Android.

If your OS is deleted or the phone is bricked, you can use the **Lenovo Recovery Tool** to recover your phone.

### 5. Root Using Magisk

1. Now, it’s time to root your device using **Magisk**.
2. On your phone, go to **Settings** and ensure that your device is connected to the PC.
3. Open a **Command Prompt** (or **Terminal**) on your PC, and type:

   ```bash
   adb reboot recovery
   ```

   Your phone will now boot into **TWRP**.

4. Once in TWRP, tap on **Advanced** and select **ADB Sideload**. Swipe the slider to enable it.
5. On your PC, type:

   ```bash
   adb devices
   ```

   You should see something like this:

   ```
   List of devices attached
   xxxxxxxxxxxxxxxx sideload
   ```

6. Now sideload the **Magisk.zip** file:

   ```bash
   adb sideload magisk.zip
   ```

7. After the installation is complete, tap on **Reboot System**. Your device will reboot back into Android.

8. Once booted up, you should see the **Magisk** app installed. Open it, and complete the setup to ensure full root access.

## GSI rom install

> coming soon ! the files are there go ahaed and try it !

## Troubleshooting

If you encounter any issues during the process, here are some common problems and solutions:

### Problem: Phone doesn't reboot into TWRP

- **Solution**: Make sure you’re following the steps correctly to enter recovery mode. If needed, try using the **ADB reboot recovery** command again.

### Problem: Magisk not showing up

- **Solution**: Reboot your phone into TWRP and reinstall Magisk.

### Problem: USB Debugging not working

- **Solution**: Ensure you have the proper drivers installed and USB debugging enabled. Restart both your phone and PC if necessary.

## FAQ

**Q1: Will rooting void my warranty?**  
A1: Yes, rooting will void your warranty. Be aware of this before proceeding.

**Q2: Can I unroot my Lenovo K8 Plus?**  
A2: Yes, you can unroot by flashing the stock firmware.

**Q3: Will I lose my data during the rooting process?**  
A3: Yes, unlocking the bootloader and rooting will erase your data. Make sure to back everything up before starting.

## License

This guide is licensed under the MIT License. See the **[LICENSE]()** file for more details.

## Credits

- **TWRP Recovery Image for Lenovo K8 Plus**: Provided by **[XDA Forum - TWRP 3.2.x for Lenovo K8 Plus](https://xdaforums.com/t/recovery-twrp-3-2-x-for-lenovo-k8-plus-marino.3838633/)**.
- **Marino GSI LineageOS Zip**: Shared by **[XDA Forum - Marino 8.1 Treble LineageOS 15.1 ROM](https://xdaforums.com/t/discontinued-rom-unofficial-marino-8-1-treble-lineageos-15-1-rom.4083099/)**.
- **ME G-flame** : creator of this guide !
