---
layout: doc
title: Getting Started with Quay.io
sublayout: solution
reviewed: 2017-04-28T17:51:00-08:00
---

<div class="alert alert-warning">Warning: Quay.io only supports docker version 1.0 or greater</div>

### Sign into Quay.io

{% include login.md %}

### Create a new image

First we'll create a Docker image, with a Dockerfile based off of the `ubuntu` base image:

```
FROM ubuntu

RUN echo 'Hello World'

```

Now we can run `docker build -t my_image .` to create the image:

```
$docker build -t my_image .
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM ubuntu
latest: Pulling from library/ubuntu
75c416ea735c: Pull complete 
c6ff40b6d658: Pull complete 
a7050fc1f338: Pull complete 
f0ffb5cf6ba9: Pull complete 
be232718519c: Pull complete 
Digest: sha256:a0ee7647e24c8494f1cf6b94f1a3cd127f423268293c25d924fbe18fd82db5a4
Status: Downloaded newer image for ubuntu:latest
 ---> d355ed3537e9
Step 2/2 : RUN echo 'Hello'
 ---> Running in f371332292b6
Hello
 ---> 3b8235e94f42
Removing intermediate container f371332292b6
Successfully built 3b8235e94f42
Successfully tagged my_image:latest

```

Now run `docker image` to see the ID and name of our image

```
docker images
REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
my_image                                latest              3b8235e94f42        54 seconds ago      119MB
```

### Tag the image

We next need to tag the image to the name of the repo we want to create.

Note that the _**username**_ must be your Quay.io username and _**reponame**_ is the new name of your repository.

```
$ docker tag my_image quay.io/username/reponame
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
