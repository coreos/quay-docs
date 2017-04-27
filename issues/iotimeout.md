---
layout: doc
sublayout: issue
title: Docker is returning an i/o timeout
reviewed: 2017-04-27T00:00:00-04:00
frontpage: True
---
Attemping to interact with a remote repository yields an `i/o timeout`.

```
$ sudo docker pull ...
FATA[0021] Error response from daemon: v1 ping attempt failed with error: Get https://quay.io/v1/_ping: dial tcp: i/o timeout.
```

## Pre-Docker 1.8

In older versions of docker, this issue was related to DNS.
Refer to [this GitHub issue](https://github.com/docker/docker/issues/13337) for more information.
First, try restarting the docker daemon process.
If this does not work, a reboot has been seen to resolve the issue.

## Docker 1.8+

In newer versions of docker, this issue is related to network infrastructure and is likely the product of latency between the client and the registry.
Ensure that there are no proxies in between the client and the registry and that the two are geographically close.
