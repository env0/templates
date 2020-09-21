#!/usr/bin/expect -f

set timeout 20

eval spawn ssh -o "StrictHostKeyChecking no" env0@$VM_IP
expect "assword:"
send "$SSH_PASSWORD\r";
interact