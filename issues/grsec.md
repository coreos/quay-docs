---
layout: doc
sublayout: issue
title: I'm getting a grsec error under Quay Enterprise
frontpage: False
---

Attempting to use certain functionality of Quay Enterprise results in the following entries in the
logs:

```
grsec: denied RWX mmap of <anonymous mapping> by /venv/bin/gunicorn[gunicorn:26829] uid/euid:0/0 gid/egid:0/0, parent /etc/service/gunicorn_web/run[run:26828] uid/euid:0/0 gid/egid:0/0
grsec: denied RWX mmap of <anonymous mapping> by /venv/bin/gunicorn[gunicorn:26946] uid/euid:0/0 gid/egid:0/0, parent /etc/service/gunicorn_web/run[run:26945] uid/euid:0/0 gid/egid:0/0
grsec: denied RWX mmap of <anonymous mapping> by /venv/bin/gunicorn[gunicorn:26955] uid/euid:0/0 gid/egid:0/0, parent /venv/bin/gunicorn[gunicorn:26946] uid/euid:0/0 gid/egid:0/0
```

### You have grsecurity enabled with too restrictive rules

grsecurity is preventing gunicorn from working properly. To fix, run the following command inside the Quay Enterprise container:

```
# paxctl -Cm /venv/bin/python
```

This can be applied automatically with the following Dockerfile:

```
FROM quay.io/coreos/registry
RUN apt-get update && \
    apt-get install -y paxctl && \
    paxctl -Cm /venv/bin/python && \
    apt-get remove -y paxctl && \
    apt-get clean && \
    rm -rf /var/lib/apt
```