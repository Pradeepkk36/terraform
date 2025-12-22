When you update an EC2 instance's storage via Terraform, AWS modifies the virtual hardware, but the Linux Operating System (OS) remains unaware of the new capacity. To make the OS recognize these changes without a reboot, you must manually extend the partition and file system.

Step 1: Increase Root Volume Size
The root disk usually has a partition (like nvme0n1p1) that stays at the old size even after the main disk (nvme0n1) grows.
Identify the device and partition: Run lsblk. You will see the disk is larger than its partition.
Grow the partition: Use growpart to expand the partition to fill the new disk space