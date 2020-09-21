#!/usr/bin/expect -f

set timeout 20

set cmd [lrange $argv 1 end]
set password [lindex $argv 0]

eval spawn $cmd
expect "assword:"
send "$SSH_PASSWORD\r";
interact