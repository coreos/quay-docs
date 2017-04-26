---
layout: doc
sublayout: issue
title: I'm receiving "Cannot locate specified Dockerfile"
reviewed: 2015-10-03T12:41:25-04:00
frontpage: True
---

When building an image on Quay.io, the following error appears:

```
A build step failed: API error (500): Cannot locate specified Dockerfile: Dockerfile
```

### The .dockerignore contains the Dockerfile

Unlike the Docker Hub, the Dockerfile is part of the [Build Context](/guides/building.html) on Quay. Thus, it must not appear in .dockerignore file.

### The Build Trigger is incorrect

Verify the Dockerfile location and the branch/tag value specified in the build trigger.

### The Dockerfile is named differently

At the moment, Quay only supports Dockerfile that are named `Dockerfile`.

Even though it is on our road map, it is currently not possible to name a Dockerfile differently. As a result, in order to have multiple Dockerfile in the same repository, they must be located in different directories or branches. Another workaround is to use multiple repositories. However, be aware that Docker's [Build Context](/guides/building.html) is the directory where Dockerfile is. There is no way to include files outside the build context, e.g. "COPY ../foo ..." does not work. 
