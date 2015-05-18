---
layout: doc
sublayout: issue
title: docker login is failing with an odd error
frontpage: True
---
Attempting to `docker login` from Quay.io results in an odd error message

### I get an error similar to this:

```
$ docker login https://quay.io/v1/
Username (username):
2014/01/01 12:00:00 Error: Invalid Registry endpoint: Get https://quay.io/v1/_ping: dial tcp: ping timeout
```

#### I'm on a high-latency slow connection

docker has defined as maximum timeout of <b>five seconds</b> before a timeout will occur. Currently, the only solution is to find a connection with a better latency. Quay.io is currently working to raise this limit to 30 seconds or so.


#### I'm running docker under a Vagrant VM

There is a known issue with Vagrant whereby networking connections can sometimes become extremely slow. A solution can be found [here](https://github.com/mitchellh/vagrant/issues/1807).

#### docker on OS X (via boot2docker) is in a weird state

If you are using docker on OSX via [boot2docker](https://github.com/boot2docker/boot2docker), the networking stack can sometimes get out of sync. To fix it, restart the boot2docker image:

```
$ boot2docker restart
```
