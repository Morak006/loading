#!/bin/bash
conf t
hostname hq-rtr
ip domain-name au-team.irpo
int isp 
description " connect ISP"
ip address 172.16.4.14/28
ex
port te0
service-instance te0/isp
encapsulation untagged
connect ip interface isp
exit
exit
interface vl100
description "Server - vlan100"
ip address 192.168.100.1/26
ex
interface vl200
description "Client - vlan200"
ip address 192.168.100.65/28
ex
interface vl999
description "Management -vlan999"
ip address 192.168.100.81/29
ex
port te1
service-instance te1/vl100
encapsulation dot1q 100 exact
rewrite pop 1
connect ip interface vl100
ex
service-instance te1/vl200
encapsulation dot1q 200 exact
rewrite pop 1
connect ip interface vl200
ex
service-instance te1/vl999
encapsulation dot1q 999 exact 
rewrite pop 1
connect ip interface vl999
ex
ex
ex
show interface description
show ip interface brief
conf t
ip route 0.0.0.0/0 172.16.4.1
write memory