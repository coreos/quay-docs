---
layout: doc
sublayout: issue
title: Docker login is failing with an odd error
reviewed: 2017-04-27T14:52:01-04:00
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

Docker has defined as maximum timeout of <b>five seconds</b> before a timeout will occur.
Currently, the only solution is to find a connection with a better latency. 


#### I'm running docker under a Vagrant VM

Note: This is probably fixed for Docker version 1.12.2 and greater.

There is a known issue with Vagrant whereby networking connections can sometimes become extremely slow. A solution can be found [here](https://github.com/mitchellh/vagrant/issues/1807).

#### docker on OS X (via boot2docker) is in a weird state

If you are using docker on OSX via [boot2docker](https://github.com/boot2docker/boot2docker), the networking stack can sometimes get out of sync. To fix it, restart the boot2docker image:

```
$ boot2docker restart
```

[Docker-machine](https://docs.docker.com/machine/) supersedes boot2docker on OSX. To fix weird state of docker, restart docker-machine:

```
$ docker-machine restart default
```
