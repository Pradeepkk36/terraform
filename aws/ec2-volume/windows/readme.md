Windows instances
Use one of the following methods to extend the file system on a Windows instance.


Disk Management utility

PowerShell
To extend a file system using Disk Management
Before extending a file system that contains valuable data, it is a best practice to create a snapshot of the volume that contains it in case you need to roll back your changes. For more information, see Create Amazon EBS snapshots.

Log in to your Windows instance using Remote Desktop.

In the Run dialog, enter diskmgmt.msc and press Enter. The Disk Management utility opens.

Windows Server Disk Management Utility

On the Disk Management menu, choose Action, Rescan Disks.

Open the context (right-click) menu for the expanded drive and choose Extend Volume.

> [!NOTE]
> Extend Volume might be disabled (grayed out) if:
> * The unallocated space is not adjacent to the drive. The unallocated space must be adjacent to the right side of the drive you want to extend.
> * The volume uses the Master Boot Record (MBR) partition style and it is already 2TB in size. Volumes that use MBR cannot exceed 2TB in size.

Windows Server Disk Management Utility

In the Extend Volume wizard, choose Next. For Select the amount of space in MB, enter the number of megabytes by which to extend the volume. Generally, you specify the maximum available space. The highlighted text under Selected is the amount of space that is added, not the final size the volume will have. Complete the wizard.

Windows Server Extend Volume Wizard

If you increase the size of an NVMe volume on an instance that does not have the AWS NVMe driver, you must reboot the instance to enable Windows to see the new volume size. For more information about installing the AWS NVMe driver, see AWS NVMe drivers.