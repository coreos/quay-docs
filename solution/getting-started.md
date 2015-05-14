---
layout: doc
title: Getting Started with Quay.io
sublayout: solution
---

<div class="alert alert-warning">Warning: Quay.io only supports docker version 1.0 or greater</div>

### Sign into Quay.io

{% include login.html %}

### Create a new container

First we'll create a container with a single new file based off of the `ubuntu` base image:

<pre class="command-example">
docker run ubuntu echo "fun" > newfile
</pre>

The container will immediately terminate (because its one command is `echo`), so we'll use `docker ps -l` to list it:

<pre class="command-example">
docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED
<var class="var1">07f2065197ef</var>       ubuntu:12.04        echo fun            31 seconds ago
</pre>

Make note of the _**container id**_; we'll need it for the commit command.

### Tag the container to an image

We next need to tag the container to a known image name

Note that the _**username**_ must be your Quay.io username and _**reponame**_ is the new name of your repository.

<pre class="command-example">
docker commit <var class="var1">07f2065197ef</var> quay.io/<var class="var2">username</var>/<var class="var3">reponame</var>
e7050e05a288f9f3498ccd2847fee966d701867bc671b02abf03a6629dc921bb
</pre>

### Push the image to Quay.io

<pre class="command-example">
docker push quay.io/<var class="var2">username</var>/<var class="var3">reponame</var>
The push refers to a repository [quay.io/<var class="var2">username</var>/<var class="var3">reponame</var>] (len: 1)
Sending image list
Pushing repository quay.io/<var class="var2">username</var>/<var class="var3">reponame</var> (1 tags)
8dbd9e392a96: Pushing [=======>         ] 21.27 MB/134.1 MB 40s
</pre>

### Pull the image from Quay.io

If any changes were made on another machine, a `docker pull` can be used to update the repository locally

<pre class="command-example">
docker pull quay.io/<var class="var2">username</var>/<var class="var3">reponame</var>
</pre>
