---
layout: doc
sublayout: issue
title: Docker is returning an i/o timeout
frontpage: True
---
Attemping to interact with a remote repository yields an `i/o timeout`.

```
$ sudo docker pull ...
FATA[0021] Error response from daemon: v1 ping attempt failed with error: Get https://quay.io/v1/_ping: dial tcp: i/o timeout.
```

This is a known issue currently in docker.
To track the progress of this issue, see [this GitHub issue](https://github.com/docker/docker/issues/13337).
Any additional feedback posted to the issue is appreciated.

### Workaround

First, try restarting the docker daemon process.
If this does not work, a reboot has been seen to resolve the issue.
