#!/bin/bash
NEW_PASS=$1

if [ ! -f /config/install.lock ]; then
   echo "$(date +%F_%R) [New Install] Lock file does not exist - new install."
   /bin/rm -v /etc/ssh/ssh_host_*
   dpkg-reconfigure openssh-server
   mv /etc/ssh /etc/ssh.bak
   cp -r /etc/ssh.bak /config/ssh
   ln -s /config/ssh /etc/ssh

   echo "$(date +%F_%R) [New Install] Creating lock file, db setup complete."
   touch /config/install.lock
fi

if [ $# -gt 0 ]; then
   echo "root:${NEW_PASS}" | chpasswd
fi

/usr/sbin/sshd -D
