---
layout: doc
sublayout: issue
title: Pulling Private Quay.io images with Marathon/Mesos fails
frontpage: True
---
Attempting to pull from a private repository with Marathon/Mesos fails with:

```
msg="Error: Status 403 trying to pull repository repo/project: \"{\\\"error\\\": \\\"Permission Denied\\\"}\""
```

### Workaround

To get Marathon/Mesos to pull from a private repository, we need to copy the docker configuration file's credentials onto the worker machines.

When using mesos app definitions, credentials must be provided as a URI that must be accessible by all nodes that may start your application.
Approaches may include distributing the file to the local filesystem of all nodes, for example via RSYNC/SCP, or storing it on a shared network drive, for example Amazon S3.
It is worth considering the security implications of each approach.

Special thanks to [Ian Saunders](https://github.com/IanSaunders) who provided this solution.

#### Pre-Docker 1.6

Download a configuration from a Quay.io credentials dialog or login to the private repository manually:

```
$ docker login quay.io
Username: myusername
Password:
Email: my@email.com
```

This process creates a configuration file in `$HOME/.dockercfg`.

Add the `.dockercfg` to the `uris` field of your mesos app definition.
The $HOME environment variable will then be set to the same value as $MESOS_SANDBOX so Docker can automatically pick up the config file.
The following is an example app defintion:

```json
{
  "id": "/some/name/or/id",
  "cpus": 1,
  "mem": 1024,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "some.docker.host.com/namespace/repo",
      "network": "HOST"
    }
  },
  "uris":  [
      "file:///etc/.dockercfg"
  ]
}
```

#### Docker 1.6+

Download a configuration from a Quay.io credentials dialog or login to the private repository manually:

```
$ docker login quay.io
Username: myusername
Password:
Email: my@email.com
```

This process creates a configuration file in `$HOME/.docker/config.json`.

Tar and gzip the `$HOME/.docker` directory and its contents:

```
$ cd $HOME
$ tar czf docker.tar.gz .docker
```

Check that both the directory and the configuration are inside the tar:

```
$ tar -tvf $HOME/docker.tar.gz
drwx------ root/root         0 2015-07-28 02:54 .docker/
-rw------- root/root       114 2015-07-28 01:31 .docker/config.json
```

_Optionally_ put the tarball into a directory readable by mesos:

```
$ cp docker.tar.gz /etc/
```

Add the file to the `uris` field of your mesos app definition:

```json
{
  "id": "/some/name/or/id",
  "cpus": 1,
  "mem": 1024,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "some.docker.host.com/namespace/repo",
      "network": "HOST"
    }
  },
  "uris":  [
      "file:///etc/docker.tar.gz"
  ]
}
```
