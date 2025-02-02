# Rooting using magisk

## Intro

    In this guide i will show how to root Lenovo K8 plus using magisk and TWRP.

## Perquisites

    - A pc preferably Windows or Linux
    - A internet connection
    - A lenovo k8 plus
    - A qualified USB cable
    - A [files](PLACEHOLDER)
    - And patience

---

## Guide !

### 1. Enable Developer Options and USB Debugging

First, enable Developer Options on your Lenovo K8 Plus:

1. Go to **Settings** on your phone.
2. Scroll down and tap **About phone**.
3. Tap **Build number** 7 times until you see a message saying that **Developer Options** are enabled.
4. Go back to the **Settings** menu and tap **Developer options**.
5. Enable **USB debugging** and **OEM unlocking**.

### 2. Install ADB on Your PC

Now you need to install **ADB** (Android Debug Bridge) on your PC:

1. Download the **[ADB and Fastboot tools](https://developer.android.com/tools/releases/platform-tools)**.
2. Extract the files and install them on your computer.
3. Once installed, you’ll use ADB to interact with your phone via the command line.

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
