# Complete Guide: Installing GSI ROMs on Lenovo K8 Plus

## What is GSI?

Generic System Image (GSI) is a pure Android implementation that can be installed on any Project Treble-supported device. It allows you to try different Android experiences on your device.

## ⚠️ Important Warnings

- This process will wipe ALL data from your device
- There's a risk of bricking your device
- Some GSIs may not work perfectly with your device
- Backup all important data before proceeding
- Your device must be rooted with TWRP installed

## Prerequisites

- Computer running Windows or Linux
- Reliable USB cable (preferably original)
- Lenovo K8 Plus with:
  - Unlocked bootloader
  - TWRP recovery installed
  - Root access (Magisk)
- [GSI Activation OS](https://ava6.androidfilehost.com/dl/rvOMSRNkVvheKyoxypWG9w/1738645536/8889791610682874881/lineage-15.1-20200415-UNOFFICIAL-marino.zip)
- Stable internet connection
- At least 70% battery

## Part 1: Installing GSI Activation OS

1. **Prepare Your Device**

   ```bash
   # Verify device connection
   adb devices

   # Expected output:
   List of devices attached
   XXXXXXXXXX    device

   # Reboot to TWRP
   adb reboot recovery
   ```

2. **Prepare File System**

   - In TWRP, navigate to:
     1. Wipe > Advanced Wipe
     2. Select "Data"
     3. Tap "Repair or Change File System"
     4. Select "Change File System"
     5. Choose EXT2 > Swipe to confirm
     6. Go back and select EXT4 > Swipe to confirm

3. **Install GSI Activation OS**
   - Go to Advanced > ADB Sideload
   - Swipe to start sideload
   - On your computer:
     ```bash
     adb sideload path/to/GSI-activator-os.zip
     ```
   - Wait for installation (progress will show in terminal)
   - After completion, tap "Reboot System"

## Part 2: Installing Custom GSI ROMs

1. **Download Your Preferred GSI**

   - Find a compatible GSI ROM (Android 10 or newer)
   - Download the system.img file
   - Transfer it to your device's storage

2. **Flash the GSI**
   - Boot into TWRP
   - Navigate to:
     1. Wipe > Advanced Wipe
     2. Select "Data"
     3. Follow file system change steps (EXT2 > EXT4)
   - Go to Install > Browse to system.img
   - Select "Install to System"
   - Swipe to confirm
   - Wait for installation to complete
   - Reboot system

## Troubleshooting

1. **Device Won't Boot**

   - Return to TWRP and repeat the process
   - If still failing, use Lenovo Smart Assistant to restore stock ROM

2. **Common Issues**

   - Normal for device to restart multiple times during first boot
   - Temporary slight overheating is normal
   - Boot time may be longer than usual

3. **GSI Compatibility**
   - Not all GSIs will work perfectly
   - Test different versions if experiencing issues
   - Check XDA Forums for compatible GSIs

## Best Practices

1. **Before Installing**

   - Make complete backup
   - Charge device fully
   - Download multiple GSIs in case one doesn't work

2. **After Installing**

   - Clear cache and dalvik cache
   - Give system 10-15 minutes for first boot
   - Test basic functionality before restoring data

3. **Maintenance**
   - Keep GSI updated
   - Maintain TWRP backup of working setup
   - Document which GSIs work well

## Additional Resources

- [XDA GSI Forum](https://forum.xda-developers.com/c/google-gsis.8180/)
- [Project Treble Documentation](https://source.android.com/docs/core/architecture/treble)
- [Lenovo K8 Plus XDA Forum](https://forum.xda-developers.com/)

# credits

[G-flame](https://github.com/g-flame)
: The creator of the guide i made thia using my own experience with my k8+