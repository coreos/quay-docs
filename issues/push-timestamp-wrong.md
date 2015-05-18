---
layout: doc
sublayout: issue
title: I just pushed but the timestamp is wrong
frontpage: True
---
A recently conducted `docker push` to Quay.io shows the wrong timestamp for one or more images

### Your machine/VM's time has desynchronized

The timestamp we show for the _Changed_ field is generated _by docker_ when the image is created. If the time on the machine on which the image was created is out of sync, the timestamp shown will be different on Quay.io as well. Usually this means a machine needs to be synced with [NTP](http://www.ntp.org).

#### boot2docker and suspend/hibernate

boot2docker users are likely to have their clocks get desynchronized when their computer is put into sleep mode or hibernation.

The following is command will force the boot2docker virtual machine to synchronze its clock:

```
$ boot2docker ssh -C 'sudo ntpclient -s -h pool.ntp.org'
```
