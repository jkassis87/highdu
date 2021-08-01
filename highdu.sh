#!/bin/bash

LFHOME() { find /home/ /backup/ -type f -size +100M -exec ls -lh {} \; | awk {'print $5, $9'} | sort -h 2> /dev/null 
	}
	
LMAIL() { find /home/*/mail/ -type d -size +100M -exec ls -lh {} \; | awk {'print $5, $9'} | sort -h 2> /dev/null 
	}

LFLOG() { find /usr/local/apache/logs/ /var/lib/mysql/ /var/log/ -type f -maxdepth 1 -size +100M -exec ls -lh {} \; | awk {'print $5, $9'} | sort -h 2> /dev/null 
	}

LDHOME() { du -Sh /home --exclude=/home/*/mail | sort -rh | head -20
	}

LSQL() { find /var/lib/mysql/ -type f -size +100M -exec ls -lh {} \; | awk {'print $5, $9'} | sort -h 2> /dev/null 
	}
	

echo -e "Hi TYPENAMEHERE,

This is a notification to alert you that the disk usage on XXXX has reached XX%.

Running out of disk space on a server can cause a number of issues with service reliability and should be addressed as soon as possible.

The two most common fixes for this issue are:

- Remove unneeded data

- Increase the total available disk space

If you'd like to explore the disk increase option, let us know in your reply and we can advise further based on your specific service.

In order to assist you with clearing space, below is a list of files and folders that are over 300MB in size:

==================================================================

Large Files Outside Home Folder"

LFLOG

echo -e "\n
Large Files In cPanel Accounts and WHM Backups if applicable"

LFHOME

echo -e "\n
Largest Directories"

LDHOME

echo -e "\n
Large Databases
NOTE: These should only be acted on by your developer. Deleting the files via SSH or FTP will break your websites"

LSQL

echo -e "\n
Large Email Accounts
NOTE: These directories refer to email accounts and should only be acted on with an email program or the cPanel Email Disk Usage tool. Deleting the folders via SSH, FTP, or cPanel File Manager will break the email account"

LMAIL

echo -e "
==================================================================

It's best practice to have you or your developers remove large files that are no longer needed.

If our assistance is required for file deletion, you must provide the exact file names and include your support PIN for verification:
"

echo -e "https://support.digitalpacific.com.au/en/knowledgebase/article/using-digital-pacifics-support-pin-for-verification"

