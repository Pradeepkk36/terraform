<!-- Parent Tab -->
<details> <summary><h3>Windows instances</h3></summary> </details>

Use one of the following methods to extend the file system on a Windows instance.

<table>
<tr>
<td>

**Tab 1**  
Content for Tab 1

</td>
<td>

**Tab 2**  
Content for Tab 2

</td>
</tr>
</table>

<!-- Parent Tab -->
<details>
<summary>Windows instances</summary>

Content for **Parent Tab 1**.

<!-- Child Tab -->
<details>
<summary>Child Tab 1.1</summary>

Content for **Child Tab 1.1**.

</details>

<details>
<summary>Child Tab 1.2</summary>

Content for **Child Tab 1.2**.

</details>

</details>


[Go to Tab 1](#Disk-Management-utility) | [Go to Tab 2](#tab-2)

### Disk Management utility
Content for Tab 1

### Tab 2
Content for Tab 2



**To extend a file system using Disk Management**  
1. Before extending a file system that contains valuable data, it is a best practice to create a snapshot of the volume that contains it in case you need to roll back your changes. For more information, see Create Amazon EBS snapshots.

2. Log in to your Windows instance using Remote Desktop.

3. In the **Run** dialog, enter **diskmgmt.msc** and press Enter. The Disk Management utility opens.

<img width="640" height="452" alt="image" src="https://github.com/user-attachments/assets/d7b736f6-fe8d-4843-8b76-addc48d0c946" />


4. On the **Disk Management** menu, choose **Action, Rescan Disks**.

5. Open the context (right-click) menu for the expanded drive and choose **Extend Volume**.

> [!NOTE]
> **Extend Volume** might be disabled (grayed out) if:
> * The unallocated space is not adjacent to the drive. The unallocated space must be adjacent to the right side of the drive you want to extend.
> * The volume uses the Master Boot Record (MBR) partition style and it is already 2TB in size. Volumes that use MBR cannot exceed 2TB in size.

<img width="633" height="300" alt="image" src="https://github.com/user-attachments/assets/b0b19eda-207a-4f12-8326-935fcc056329" />


6. In the Extend Volume wizard, choose Next. For Select the amount of space in MB, enter the number of megabytes by which to extend the volume. Generally, you specify the maximum available space. The highlighted text under Selected is the amount of space that is added, not the final size the volume will have. Complete the wizard.  

<img width="633" height="300" alt="image" src="https://github.com/user-attachments/assets/d8c0133c-519e-4f67-b3cb-5416f63450f0" />

7. If you increase the size of an NVMe volume on an instance that does not have the AWS NVMe driver, you must reboot the instance to enable Windows to see the new volume size. For more information about installing the AWS NVMe driver, see AWS NVMe drivers.

