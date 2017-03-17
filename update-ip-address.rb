#!/usr/bin/env ruby
require 'resolv'
ip = Resolv.getaddress "--YOUR-dynamic-DNS-here"
`iptables -F FRIENDS`
`iptables -A FRIENDS -s #{ip} -j ACCEPT`
`iptables -A FRIENDS -j DROP`
