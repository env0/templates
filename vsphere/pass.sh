#!/usr/bin/expect -f

set timeout 20

expect "assword:"
send "$SSH_PASSWORD\r";
interact