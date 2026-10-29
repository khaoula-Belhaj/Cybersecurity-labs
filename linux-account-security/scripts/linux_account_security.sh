#!/usr/bin/env bash
# Linux account security lab - commands executed during the lab.
# WARNING: run only in a disposable lab VM (creates/deletes users, toggles shadowing).

# 1. File system exploration
ls /
which ls

# 2. Password shadowing
pwunconv                    # disable shadowing: hashes move back into /etc/passwd
cat /etc/passwd
ls -l /etc/passwd           # world-readable -> hashes exposed
pwconv                      # re-enable shadowing
cat /etc/shadow
ls -l /etc/shadow           # readable by root only

# 3. Accounts and groups
useradd -m user3
passwd user3
ls /home
sudo cat /etc/shadow | grep user3        # last password change (days since 1970-01-01)
date -d "1970-01-01 + 19800 days"        # convert that value to a date (example value)
id -u user3                              # UID
id -gn user3                             # primary group
id -Gn user3                             # all groups
userdel user1

# 4. Switching users
su -
su -s /bin/bash - user3

# 5. Compression
ls -lh new1
gzip new1
ls -lh new1.gz
gzip -d new1.gz

# 6. Scheduled tasks
crontab -l
