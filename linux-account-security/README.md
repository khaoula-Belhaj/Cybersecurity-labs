# Linux Account Security & Administration

Hands-on Linux administration focused on **account security**: how password hashes are stored and protected, user and group management, privilege delegation with `sudo`, password aging policies and task scheduling with `cron`.

> Academic labs — Network & System Administration module, ENSA Fez (GSCSI), 2024–2025.

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420) ![Security](https://img.shields.io/badge/Security-hardening-red) ![Bash](https://img.shields.io/badge/Shell-bash-black)

---

## 1. Password shadowing — why `/etc/shadow` exists

| Step | Command | Observation |
|---|---|---|
| Disable shadowing | `pwunconv` then `cat /etc/passwd` | Password **hashes appear in `/etc/passwd`**, which is readable by every user |
| Analyse a hash | `$1$<salt>$<hash>` | `$1$` = **MD5-crypt**; the **salt** makes identical passwords produce different hashes and defeats precomputed (rainbow table) attacks |
| Check permissions | `ls -l /etc/passwd` | World-readable → hashes exposed to dictionary attacks |
| Re-enable shadowing | `pwconv` then `cat /etc/shadow`, `ls -l /etc/shadow` | Hashes moved to `/etc/shadow`, **readable by root only** |

## 2. Users and groups

```bash
useradd -m user3          # create a user with a home directory
passwd user3              # set its password
id -u user3               # UID
id -gn user3              # primary group
id -Gn user3              # all groups
usermod -aG <group> user3 # add to a supplementary group without removing others
userdel user1             # delete an account
```

Distinguished **human accounts** (e.g. user4, user8) from **system accounts** (e.g. root, daemon, man) in `/etc/passwd`, and decoded the last password change date stored in `/etc/shadow` (`date -d "1970-01-01 + N days"`).

## 3. Privileges and account policies

- **Switching users:** `su -`, `su root`, `su -s /bin/bash - user3`.
- **Privilege delegation:** worked with the `sudoers` configuration that controls who may run administrative commands.
- **Account properties with `chage`:** last password change date, account locking, account expiration and password update periodicity.

## 4. Compression, archiving and task scheduling

- Compression with `gzip` (size comparison with `ls -lh`, decompression, compression ratio) and archiving with `tar`, alone and combined with compression.
- Scheduled jobs with `crontab`: created, listed (`crontab -l`) and removed jobs, and compared running a script manually versus through cron.

## Security takeaways

1. Never store password hashes in a world-readable file — shadowing is mandatory.
2. Salted hashes defeat precomputed attacks; modern systems use stronger algorithms than MD5 (SHA-512, yescrypt).
3. Least privilege: delegate with `sudo` instead of sharing the root password.
4. Enforce password aging on user accounts.

## Skills demonstrated

Linux administration · account security · `/etc/passwd` & `/etc/shadow` · password hashing & salting · users/groups · sudoers · chage · gzip/tar · crontab

## Documentation

- [Full report (French)](docs/report-linux-users-crontab.pdf)

---

**Author:** Khaoula Belhaj — final-year engineering student, Communicating Systems & Computer Security, ENSA Fez · [LinkedIn](https://linkedin.com/in/khaoula-belhaj-1999163a6)
