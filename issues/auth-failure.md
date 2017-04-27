---
layout: doc
sublayout: issue
title: I'm authorized but I'm still getting 403s
reviewed: 2017-04-26T17:30:00-04:00
frontpage: True
---

Attempting to push or pull to.from Quay.io results in a `403` even after a successful `docker login`

### You are using CentOS 7

CentOS 7 introduced a custom build of docker with a known issue that prevents logging into private registries (more information [here](https://bugzilla.redhat.com/show_bug.cgi?id=1209439)).

#### Workaround

Please upgrade your version of Docker.

### You are using docker version 0.8.1

docker 0.8.1 introduced [a bug](https://github.com/dotcloud/docker/issues/4267) in its storage of auth credentials in the `.dockercfg` file that results in no credentials being sent to Quay.io, despite a successful login.

#### Workaround

Please upgrade your version of Docker.

### You are executing docker in a different environment

docker stores the credentials it uses for push and pull in a file typically placed at `$HOME/.docker/config.json`.

If you are executing docker in another environment (scripted `docker build`, virtual machine, makefile, virtualenv, etc), docker will not be able to find the `config.json` file and will fail.

_Make sure that the `config.json` is accessible to the environment which is performing the push or pull_.

### You do not have permission on the repository

Make sure that your user/robot account/token has permission on the repository. Permissions on a repository can be edited from the [permissions view](/guides/repo-permissions.html). Note that if you are trying to push/pull an organization repository, your account must either have permissions OR be a member of a [team](/glossary/teams.html).
