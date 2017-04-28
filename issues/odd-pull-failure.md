---
layout: doc
sublayout: issue
title: Pulls are failing with an odd error
reviewed: 2017-04-27T15:11:56-04:00
frontpage: True
---
Attempting to `docker pull` from Quay.io results in an odd error message


### I get an error similar to this:

```
Pulling repository quay.io/my/repository
39cb5a2eab5d: Error pulling image (myimage) from quay.io/my/repository, link /var/lib/docker/devicemapper/mnt/bd6de6dfce
5377faae6d1b4234b8f3221087210332/rootfs/var/lib/dpkg/available-old:
no such file or directory old: no such file or directory 0143e54a: Download complete
bd6de6dfce2d: Error downloading dependent layers
2014/01/01 01:01:01 Could not find repository on any of the indexed registries.
```

#### Linux kernel bug on Ubuntu Precise Pangolin (12.04 LTS) (64-bit)

Precise has a linux kernel bug that must be updated in order to use docker. Follow these instructions and _make sure to reboot_ before trying again.

```
$ sudo apt-get update
$ sudo apt-get install linux-image-generic-lts-raring linux-headers-generic-lts-raring
$ sudo reboot
```

#### Missing AUFS on Raring 13.04 and Saucy 13.10 (64-bit)

Not all installations of Ubuntu 13.04/13.10 ship with AUFS enabled. Follow these instructions.

```
$ sudo apt-get update
$ sudo apt-get install linux-image-extra-`uname -r`
```
