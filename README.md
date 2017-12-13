# docker-veeam-data-mover
the scripts creates a docker veeam data mover servlet.

---
Simple SSH Servlet with perl requirements documented by veeam
https://helpcenter.veeam.com/docs/backup/vsphere/linux_server.html?ver=95

Binds SSH to Port 60022, and the port range 2500-2550 for communication with veeam. The run scripts create persistant bind mounts for /data and /config. To change this behaviour you must edit Dockerfile and run.sh.

It's possible to change the root password after building by setting the second run.sh script argument.

## build
Usage: ./build.sh "<ssh_root_password>"

### Example:
```
manuel@vie-ws-187 % ./build.sh "4kYcEiiL17Z8ZZQKAVysd-.23§bdfl-y\--ybRrGkCZ"
...
Successfully built aeadff81238f
Successfully tagged vexs/veeam-data-mover:latest
```

## run
Usage: ./run.sh <customer_prefix> [<new_root_password>]

### Example
```
manuel@vie-ws-187 % ./run.sh testucstomer
+ docker run -d -p 60022:22 -p 2500-2550:2500-2550 --restart unless-stopped --name veeam-testucstomer-remoterepo --restart on-failure:1 -v /veeam/testucstomer/data:/data:rw -v /veeam/testucstomer/config:/config:rw vexs/veeam-data-mover:latest
8919cef1f1f1176edce9c6b2d20473791aaac055fb9f372e57ad3a74dd6b6e66

manuel@vie-ws-187 % ssh root@localhost -p 60022
root@localhost's password: 
Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-24-generic i686)

 * Documentation:  https://help.ubuntu.com/

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

root@8919cef1f1f1:~# logout
Connection to localhost closed.
```
