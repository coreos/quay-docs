---
layout: doc
sublayout: issue
title: Pulling Private Quay.io images with Marathon/Mesos fails
frontpage: True
---

#### Special thanks to [Ian Saunders](https://github.com/IanSaunders) who provided this solution.

Attempting to pull from a private repository with Marathon/Mesos fails with:

```
msg="Error: Status 403 trying to pull repository repo/project: \"{\\\"error\\\": \\\"Permission Denied\\\"}\""
```

### Workaround

To get Marathon/Mesos to pull from a private repository, we need to copy the `.docker/config.json`
credentials onto the worker machines.

#### Step 1: Create or Download Credentials

Login to the private repository manually or download a `config.json` from a Quay.io credentials dialog

```
$ docker login quay.io
Username: myusername
Password:
Email: my@email.com
```

This creates a `.docker` folder and a `.docker/config.json` in your home directory.


#### Step 2: tar+gzip the credentials

Tar and GZip the `.docker` folder and its credentials:

```
$ cd ~
$ tar czf docker.tar.gz .docker
```

Check you have both files in the tar:

```
$ tar -tvf /etc/docker.tar.gz
```

Put the gziped file in location which won't get reset:

```
$ cp docker.tar.gz  /etc/
```

#### Step 3: Mesos/Marathon config

Add the path to the gziped login credentials to your marathon app definition:

```
"uris": [
  "file:///etc/docker.tar.gz"
]
```

For example:

```json
{
  "id": "/some/name/or/id",
  "cpus": 1,
  "mem": 1024,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "quay.io/namespace/repo",
      "network": "HOST"
    }
  },
  "uris": [
    "file:///etc/docker.tar.gz"
  ]
}
```
