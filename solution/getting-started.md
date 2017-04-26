---
layout: doc
title: Getting Started with Quay.io
sublayout: solution
reviewed: 2015-05-15T16:32:20-04:00
---

<div class="alert alert-warning">Warning: Quay.io only supports docker version 1.0 or greater</div>

### Sign into Quay.io

{% include login.md %}

### Create a new container

First we'll create a container with a single new file based off of the `ubuntu` base image:

```
$ docker run ubuntu echo "fun" > newfile
```

The container will immediately terminate (because its one command is `echo`), so we'll use `docker ps -l` to list it:

```
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED
07f2065197ef        ubuntu:12.04        echo fun            31 seconds ago
```

Make note of the _**container id**_; we'll need it for the commit command.

### Tag the container to an image

We next need to tag the container to a known image name

Note that the _**username**_ must be your Quay.io username and _**reponame**_ is the new name of your repository.

```
$ docker commit 07f2065197ef quay.io/username/reponame
e7050e05a288f9f3498ccd2847fee966d701867bc671b02abf03a6629dc921bb
```

### Push the image to Quay.io

```
$ docker push quay.io/username/reponame
The push refers to a repository [quay.io/username/reponame] (len: 1)
Sending image list
Pushing repository quay.io/username/reponame (1 tags)
8dbd9e392a96: Pushing [=======>         ] 21.27 MB/134.1 MB 40s
```

### Pull the image from Quay.io

If any changes were made on another machine, a `docker pull` can be used to update the repository locally

```
$ docker pull quay.io/username/reponame
```
