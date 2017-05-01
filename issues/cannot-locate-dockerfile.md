---
layout: doc
sublayout: issue
title: I'm receiving "Cannot locate specified Dockerfile"
reviewed: 2017-05-01T12:41:25-08:00
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
