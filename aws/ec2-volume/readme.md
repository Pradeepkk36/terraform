**When you update an EC2 instance's storage via Terraform, AWS modifies the virtual hardware, but the Linux Operating System (OS) remains unaware of the new capacity. To make the OS recognize these changes without a reboot, you must manually extend the partition and file system.**

## Increase Root Volume Size
The root disk usually has a partition (like  `nvme0n1p1`) that stays at the old size even after the main disk (`nvme0n1`) grows.
Identify the device and partition: Run `lsblk`. You will see the disk is larger than its partition.

Grow the partition: Use growpart to expand the partition to fill the new disk space

## AWS EC2 Storage Expansion: Terraform & Linux Guide

This guide explains how to ensure your Linux Operating System recognizes a root volume size increase and a new additional EBS volume after applying changes via **Terraform**.

### 🚀 The Problem

When you increase the `volume_size` in Terraform or add an `aws_volume_attachment`, Terraform modifies the **AWS hardware layer**. However, the **Linux OS layer** does not automatically expand its partitions or format new disks. 

Commands like `df -Th` will not show the changes until you manually extend the filesystem.

---

### 🛠 Step 1: Resize the Root Volume
If you increased your root volume (e.g., from 8GB to 50GB), follow these steps:

#### 1. Verify the mismatch
Run `lsblk` to see that the disk is larger than the partition.
```
lsblk
# Example output:
# nvme0n1     259:0    0   50G  0 disk 
# └─nvme0n1p1 259:1    0    8G  0 part /
```
#### 2. Grow the Partition
Use growpart to expand the partition to fill the disk.
```bash
# Syntax: sudo growpart <device> <partition_number>
sudo growpart /dev/nvme0n1 1
```

#### 3. Expand the Filesystem
Tell the OS to use the new space available in the partition.
**For XFS (Amazon Linux, RHEL, CentOS):**
```
sudo xfs_growfs -d /
```
**For EXT4 (Ubuntu, Debian):**
```
sudo resize2fs /dev/nvme0n1p1
```

### 📂 Step 2: Initialize a New EBS Volume
If you attached a brand-new EBS volume via Terraform, it arrives as "raw" storage. You must format it and mount it.
#### 1. Identify the new device
```bash
lsblk
# for the disk with no MOUNTPOINT (e.g., nvme1n1)
```
#### 2. Format the Volume
Only format if the volume is empty!
```
sudo mkfs -t xfs /dev/nvme1n1
```

#### 3. Mount the Volume
```
sudo mkdir /data
sudo mount /dev/nvme1n1 /data
```

#### 4. Make it Persistent**  
To ensure the volume mounts automatically after a reboot, add it to `/etc/fstab`<br/>  Find the UUID: sudo blkid `/dev/nvme1n1`<br/>  Add this line to `/etc/fstab:`
```
UUID=your-uuid-here  /data  xfs  defaults,nofail  0  2
```

### 🔍 Verification Checklist
| Goal | Command | Result |
| --- | --- | --- |
| Check Block Devices | `lsblk` | Partition matches Disk size |
| Check Mounted Space | `df -Th` | Root (`/`) shows new GiB |
| Check New Volume | `df -Th` | `/data` (or your mount) is visible |


### 📝 Troubleshooting
* **Command not found:** Install cloud-utils (e.g., `sudo yum install cloud-utils-growpart` or `sudo apt-get install cloud-guest-utils`).
* **Permission Denied:** Ensure you are running all commands with `sudo`.
* **Cannot Decrease Size:** AWS EBS does not support shrinking volumes. This must be done via data migration to a smaller volume.
