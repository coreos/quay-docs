---
layout: doc
title: Repeatable and Testable Deployments
sublayout: solution
---

### The perils of deployment

Deploying to production: words that for many developers can chill their hearts to the core. Even with extensive testing and today’s scriptable deployment systems (Chef, Puppet, etc), deployment to production machines can still result in cryptic errors, odd behaviors and lots of inventive swearing. All this stress and headache stems from one primary issue: Production environments rarely, if ever, replicate staging or development environments completely. Unit tests are run on development machines or in continuous integration systems; integration tests are run on staging machines or by hand. These different environments try to replicate production as closely as possible, but even the slightest difference can result in disaster. Differences in libraries, file layouts, even minor revisions of the operating system, can result in unexpected behavior and downtime. We once had a production push breakage (in our previous product) as a result of _the method used to link a dependency_. Even though we had matched the versions of the library and the operating system exactly, we still encountered problems.

Fortunately, we discovered that Docker can come to the rescue, solving not only the environment problem, but helping to grant us further peace of mind by properly testing our deployments before they go to production.

This article will discuss how to setup Docker for *reproducible*, *tested* deployments. If you need background on the terms used in this article, please read our article [What is Docker?](https://medium.com/devops-programming/7f5fd023158f) first.

### Being environmentally friendly

The first major benefit of using Docker for deployment is its ability to reproduce a specific environment, quickly and on demand. A Docker container represents a sandbox of sorts, one in which a developer can finely control all dependencies of their software, including operating system version, library installation and supporting files. As a result, any software running inside the Docker container is guaranteed to be running under the same environment, whether on a developer’s machine, staging or production:

The reproducibility of the Docker container provides a level of comfort that current script-based deployment systems simply cannot match. A developer can develop a new version of a service on their machine, test it locally or on staging and then push the **same image** to production with the understanding that the testing environment **is** the production environment under which their code will now be running.

<div class="article-image"><img src="image00.png"></div>

### Preparing a Docker image

Preparing images to run in Docker can be done in one of two ways: by manually building layers or via a Dockerfile, which allows for reproducible construction of images. Since reproducibility is the goal of our production deployments, we will write a Dockerfile that represents our production code and its dependencies. For this article, we’ll set up a simple web server that writes “Hello World”. The source code for the web server and its associated Dockerfile can be found [here](https://github.com/DevTable/rtdexample).

At its core, a Dockerfile is a simple list of commands building on top of a _base image_, with each command forming a new layer in the Docker image. The base image of a Docker image is extremely important: It defines the flavour of Linux used, and which tools are by available by default to the code running inside the container. At Quay.io, we recommend the [phusion/baseimage](https://github.com/phusion/baseimage-docker), which runs a version of Ubuntu specially modified to run inside a Docker container.

To get started, we create a file named `Dockerfile` in the directory containing our existing code. The first line of a Dockerfile is, typically, the `FROM` command, which indicates the base image we are using (in this case, Phusion base). The Phusion base image can be found on the public Docker index at phusion/baseimage, so we place that directly in the FROM line:

```dockerfile
FROM phusion/baseimage:0.9.9
```

The `:0.9.9` above specifies that we are requesting that specific _tag_ of the `baseimage` repository. Without a specific tag, the `latest` tag would always be used; any update to the `baseimage` repository could get pulled by our Dockerfile at any time, leading to possible breakages.

Once we have specified the base image, it is customary to add a `MAINTAINER` command. This "command" (which has no effects) indicates the author of the Dockerfile:

```dockerfile
FROM phusion/baseimage:0.9.9
MAINTAINER John Smith <john.smith@example.com>
```

### Working in a good ENVironment

In order to use the Phusion base image we just setup, we need to tell it a home directory for our root user, as well as the fact that (under normal circumstances), the Docker image will not be running with an interactive terminal. Docker allows environment variables to be set using the `ENV` command, so we add two environment variables to our context;

```dockerfile
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
```

### All your base are belong to this

Now that we have the base image setup, our next step is to start adding the dependencies upon which our service will rely. Dockerfile’s provide a number of commands for adding dependencies; this article will cover the three or four most important commands needed for setting up the environment for our web service.

Our [web service](https://github.com/DevTable/rtdexample) is a Python application, which depends on [PyPI](https://pypi.python.org/pypi) to manage its own libraries. We therefore start by installing Python and PyPI:

```dockerfile
# Install Ubuntu packages.
# New packages should be added as their own apt-get install lines below the existing install commands.
RUN apt-get update
RUN apt-get install -y python-dev
RUN apt-get install -y python-pip
```

The `RUN` command in a Dockerfile will run any command given, under the context and file system of the Docker container, and produce a new image layer with any resulting file system changes. We first run `apt-get update` to make sure our package manager is up to date. Then, in different calls, we ask our package manager to install both python and pip. The `-y` flag skips interactive confirmation.

As an aside: Why do we run each of the `apt-get -y install` commands on their own? The answer lies in how Docker handles _caching_. When building a Dockerfile, Docker will first check its own image cache to see if any of the layers previously built exist. If so, the build step will be skipped and the previous layer used. By placing each install command on its own, if we ever need to add or remove a package, we can do so without having to "reinstall" every other package used inside the Dockerfile, saving potentially large amounts of build time.

Once we’ve installed all the Ubuntu packages necessary to run our service, we conduct a bit of cleanup. This is not strictly necessary, but it does mean that the resulting Docker image is cleaner:

```dockerfile
# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

Our next step is to have PyPI install all the required libraries and packages necessary for our Python application. To do so, we’ll use the `pip install -r requirements.txt` convention, which installs all packages specified in a `requirements.txt` file.

The problem is…how are we going to get our `requirements.txt` file into the proper directory? The answer: using the `COPY` command.

### COPYing dependencies

The `COPY` command specifies that a file, located at the input path, should be copied from the same directory as the Dockerfile to the output path inside the container. For example, an `COPY` command like:

```dockerfile
COPY config/somefile.txt myapp/anotherfile.txt
```

will copy the file located at `config/somefile.txt` (relative to the Dockerfile’s directory) to `myapp/anotherfile.txt` relative to the working directory inside the container.

Therefore, for our purposes, it is simple to add our `requirements.txt` and install it. Note that we also call `WORKDIR` to ensure that all our commands are run inside the `/root` folder:

```dockerfile
# Change our working directory to /root
WORKDIR /root

# Copy over our requirements.txt
COPY requirements.txt /root/requirements.txt

# Install our Python dependencies.
RUN pip install -r requirements.txt
```

### Asset management

As we’ve seen, the `COPY` command can be used to add external files into the Docker image. Once we’ve installed our Python dependencies, our next step is to `COPY` any assets (including the web service’s code), to the Dockerfile. This can be done in steps or by copying entire directories:

```dockerfile
# Copy over code and static assets.
COPY static /root/static
COPY application.py /root/application.py
```

A question might be raised at this point: Why not copy all the static assets along with `requirements.txt` in the earlier part of the Dockerfile? The answer, once again, has to do with _caching_. The Dockerfile caching system will invalidate _all_ steps after _any_ `COPY` command that has a file that has changed, since it has been called. In our Dockerfile example, if we placed `COPY static /root/static` _before_ the `pip install -r requirements.txt` call, then any time we changed a static asset file, the entire PyPI installation process would be called again. Since that is obviously not the behavior we’d like, you should try to _place dependencies as late as possible when ordering these commands_.

### Running your service

The final step in setting up a service via a Dockerfile is to have said Dockerfile invoke the service when the image is run. Since we are using the Phusion Base Image, we can take advantage of its embedded init service to run our application. To do so, we copy a shell script into the services directory. The shell script will be automatically run and started when the container first starts:

```dockerfile
# Add my runservice.sh shell script as a service and make sure it has the proper flags
COPY runservice.sh /etc/service/mywebserver/run
RUN chmod +x /etc/service/mywebserver/run
```

Our final task is to tell Docker that we are exposing ports for our web service, and to call the init service described above. The `EXPOSE` command indicates to Docker the ports that should be exposed by the container when run and the `CMD` command tells Docker the command to run when the container is started:

```dockerfile
# Tell Docker that we are exposing the HTTP ports
EXPOSE 443 80

# Finally, tell Docker to run the init service.
CMD ["/sbin/my_init"]
```

We are now done our Dockerfile and can discuss different ways to build it.

### Building and deploying our new image

Building a Dockerfile into an image is quite simple. In the directory that contains the Dockerfile and its data files (requirements.txt, static, etc), one simply executes:

```
$ docker build -t quay.io/mynamespace/myreponame .
```

The command above tells Docker to _build_ the Dockerfile and data found in the current directory and, if sucessful, to _tag_ it as the repository named _quay.io/mynamespace/myreponame._

At this point you'll need an [Quay.io account](https://quay.io/signin) to make further progress.

Once our build has been successful, we can then _push_ our created image to Quay.io:

```
$ docker push quay.io/mynamespace/myreponame
```

and on our production server, _pull_ and _run_ it:

```
$ docker run quay.io/mynamespace/myreponame -d
```

The `-d` flag tells Docker to run the image in detached (background) mode, rather than waiting until the container exits to return the prompt.

### Tested deployments

As we can see, it is a fairly simple and straightforward process to use a Dockerfile and `docker build` to create a reproducible runtime environment for our server, including all its dependencies, libraries and static assets. This is a very useful solution to a large portion of the deployment issues we discussed above, but it still leaves much to be desired; even if we have a test suite running on our code at all times, we still cannot be sure that our code runs the same under our test environment as our production environment.

Unit tests are the obvious solution; they can help to identify problems in our production image before we push it, and verify that it at least (partially) functions the way we intend. Since Docker allows us to run any command during the build process, we can take advantage of this fact to run our unit tests _while building the image_. If our tests succeed, we have some confidence that the runtime environment for our service is valid; if they fail, then the build fails, and we will have not created a potentially bad production image.

Running tests as part of the build process is quite easy; we simply execute a `RUN` command with our test runner. For example, since we are writing a Python web service, here is the testing command we’ll add to our Dockerfile:

```dockerfile
RUN python -m unittest discover
```

The above command will discover and run any unit tests found in our Python source code. To that end, we also need to make sure to `COPY` our unit tests to the assets inside our image:

```dockerfile
COPY test /root/test
```

Finally, we should delete any test files once our unit tests run. We do so to ensure that our production code cannot rely (accidentally or on purpose) on our test code:

```dockerfile
RUN rm -rf test
```

Altogether, this results in the following being added to the Dockerfile:

```dockerfile
# Add my runservice.sh shell script as a service and make sure it has the proper flags
COPY runservice.sh /etc/service/mywebserver/run
RUN chmod +x /etc/service/mywebserver/run

# Test our production image.
COPY test /root/test
RUN python -m unittest discover
RUN rm -rf test

# Tell Docker that we are exposing the HTTP ports
EXPOSE 443 80

# Finally, tell Docker to run the init service.
CMD ["/sbin/my_init"]
```


Every time we build our image, it’ll be fully tested as part of the build process, resulting in a _tested_, _reproducible_ production environment!

### Automating this process

While the above build process is very simple and straightforward, it suffers from one major downside: it requires a developer or devops engineer to rebuild the image before every production push. Recognizing this problem, Quay.io has [built support for automatically building Dockerfiles on pushes to any Github repository](http://blog.devtable.com/2014/03/link-your-quayio/repositories-to-github.html). To setup, go to the Admin Panel for your Quay.io repository and create a new "Github repository trigger" under the "Build Triggers" tab. Once authenticated and setup, any time a developer pushes to your Github repository, Quay.io will pickup the changes, conduct the Dockerfile build and, if successful, push the new image to your repository. If the build fails for whatever reason (including test failures), results can be viewed in the build history.

As an example, we’ve created a repository in Quay.io that builds the Dockerfile and service contained in this article, which you can view [here](https://quay.io/repository/quay/rtdeample).

We think that Docker and Dockerfiles provide a unique ability for both developers and devops engineers to be more confident in their production deployment. When used with Quay.io’s automatic build systems, engineers can be confident that code is both tested and ready for deployment as soon as possible. [Try Quay.io today!](https://quay.io)
