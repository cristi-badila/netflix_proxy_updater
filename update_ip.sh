#!/usr/bin/expect -f
spawn ssh root@45.55.169.62
expect "# "
send "ruby /opt/netflix-proxy/update-ip-address.rb\r"
expect "# "