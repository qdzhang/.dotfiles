#!/bin/sh

# Use firewalld to config clash transparent proxy

#tcp
sudo firewall-cmd --direct --add-chain ipv4 nat clash
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -m cgroup --path "noproxy.slice" -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 0.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 10.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 127.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 169.254.0.0/16 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 172.16.0.0/12 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 192.168.0.0/16 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 224.0.0.0/4 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 nat clash 1 -d 240.0.0.0/4 -j RETURN

sudo firewall-cmd --direct --add-rule ipv4 nat clash 2 -p tcp -j REDIRECT --to-port 7892
sudo firewall-cmd --direct --add-rule ipv4 nat OUTPUT 1 -p tcp -j clash

#udp
sudo ip rule add fwmark 1 table 100
sudo ip route add local default dev lo table 100
sudo firewall-cmd --direct --add-chain ipv4 mangle clash
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -m cgroup --path "noproxy.slice" -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 0.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 10.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 127.0.0.0/8 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 169.254.0.0/16 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 172.16.0.0/12 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 192.168.0.0/16 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 224.0.0.0/4 -j RETURN
sudo firewall-cmd --direct --add-rule ipv4 mangle clash 1 -d 240.0.0.0/4 -j RETURN

sudo firewall-cmd --direct --add-rule ipv4 mangle clash 2 -p udp -j TPROXY --on-port 7892 --tproxy-mark 1
# sudo firewall-cmd --direct --add-rule ipv4 mangle OUTPUT 1 -p udp -j clash

# sudo ip rule add fwmark 1 table 100
# sudo ip route add local default dev lo table 100
# sudo firewall-cmd --direct --add-chain ipv4 nat clash_udp
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -m cgroup --path "noproxy.slice" -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 0.0.0.0/8 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 10.0.0.0/8 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 127.0.0.0/8 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 169.254.0.0/16 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 172.16.0.0/12 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 192.168.0.0/16 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 224.0.0.0/4 -j RETURN
# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 1 -d 240.0.0.0/4 -j RETURN

# sudo firewall-cmd --direct --add-rule ipv4 nat clash_udp 2 -p udp -j REDIRECT --to-port 7892
# sudo firewall-cmd --direct --add-rule ipv4 nat OUTPUT 1 -p udp -j clash_udp

sudo firewall-cmd --direct --add-chain ipv4 nat CLASH_DNS
sudo firewall-cmd --direct --remove-rules ipv4 nat CLASH_DNS
sudo firewall-cmd --direct --add-rule ipv4 nat CLASH_DNS 1 -p udp -j REDIRECT --to-port 1053
sudo firewall-cmd --direct --add-rule ipv4 nat OUTPUT 0 -p udp --dport 53 -j CLASH_DNS
