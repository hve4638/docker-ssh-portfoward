#!/bin/sh

chmod 700 /home/sshonly/.ssh

if [ ! -f /home/sshonly/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -f /home/sshonly/.ssh/id_rsa -N ""
    mv /home/sshonly/.ssh/id_rsa.pub /home/sshonly/.ssh/authorized_keys
    
    chmod 400 /home/sshonly/.ssh/authorized_keys
    chmod 400 /home/sshonly/.ssh/id_rsa
    chown sshonly:sshonly /home/sshonly/.ssh/authorized_keys
    chown sshonly:sshonly /home/sshonly/.ssh/id_rsa
fi

/usr/sbin/sshd -D

