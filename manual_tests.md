# Manual tests logs


## From second region to first

```bash
  ~/labs/skills/tf-code-for-2-regions   ec2_and_manual_test ●  ssh ubuntu@35.180.83.170
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-1029-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Dec 21 13:49:59 UTC 2020

  System load:  0.0               Processes:           92
  Usage of /:   2.3% of 48.41GB   Users logged in:     0
  Memory usage: 18%               IP address for eth0: 172.16.1.60
  Swap usage:   0%


0 packages can be updated.
0 updates are security updates.

New release '20.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Mon Dec 21 12:56:35 2020 from 77.162.119.95
ubuntu@ip-172-16-1-60:~$ ping 10.1.0.177
PING 10.1.0.177 (10.1.0.177) 56(84) bytes of data.
64 bytes from 10.1.0.177: icmp_seq=1 ttl=64 time=18.1 ms
64 bytes from 10.1.0.177: icmp_seq=2 ttl=64 time=18.1 ms
64 bytes from 10.1.0.177: icmp_seq=3 ttl=64 time=18.1 ms
64 bytes from 10.1.0.177: icmp_seq=4 ttl=64 time=18.0 ms
^C
--- 10.1.0.177 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 18.082/18.130/18.155/0.137 ms
ubuntu@ip-172-16-1-60:~$ logout
Connection to 35.180.83.170 closed.
```

## From first region to second

```bash
 ~/labs/skills/tf-code-for-2-regions   ec2_and_manual_test ●  ssh ubuntu@54.194.192.36
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-1029-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Dec 21 13:46:41 UTC 2020

  System load:  0.0               Processes:           93
  Usage of /:   2.7% of 48.41GB   Users logged in:     0
  Memory usage: 19%               IP address for eth0: 10.1.0.177
  Swap usage:   0%


11 packages can be updated.
7 updates are security updates.

New release '20.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Mon Dec 21 13:45:53 2020 from 77.162.119.95
ubuntu@ip-10-1-0-177:~$ sudo su -
root@ip-10-1-0-177:~# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 10.1.0.177  netmask 255.255.255.0  broadcast 10.1.0.255
        inet6 fe80::8b2:8bff:feb9:7251  prefixlen 64  scopeid 0x20<link>
        ether 0a:b2:8b:b9:72:51  txqueuelen 1000  (Ethernet)
        RX packets 17352  bytes 23631623 (23.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2362  bytes 258947 (258.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 232  bytes 20381 (20.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 232  bytes 20381 (20.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@ip-10-1-0-177:~# ping 172.16.1.60
PING 172.16.1.60 (172.16.1.60) 56(84) bytes of data.
64 bytes from 172.16.1.60: icmp_seq=1 ttl=64 time=19.8 ms
64 bytes from 172.16.1.60: icmp_seq=2 ttl=64 time=19.8 ms
^C
--- 172.16.1.60 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 19.804/19.843/19.883/0.146 ms
root@ip-10-1-0-177:~# logout
ubuntu@ip-10-1-0-177:~$ logout
Connection to 54.194.192.36 closed.
```