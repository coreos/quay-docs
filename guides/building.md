---
layout: doc
sublayout: guide
title: Building Dockerfiles
---

Quay.io supports the ability to build [Dockerfiles](http://docs.docker.com/reference/builder/) on our build fleet, and push the resulting image to the repository.

## Viewing and managing builds

Repository Builds can be viewed and managed by clicking the <span class="tab-reference"><i class="tab-icon fa fa-tasks"></i>Builds</span> tab in the [Repository View](/guides/repo-view.html).

## Manually starting a build

To manually start a repository build, click the `+` icon in the top right of the header on any repository page and choose 'New Dockerfile Build'. A `Dockerfile` or a `.tar.gz` or an HTTP URL to either can be uploaded for the build.

## Build Triggers

Repository builds can also be automatically triggered by events such as a push to an SCM (GitHub, BitBucket or GitLab) or via [a call to a webhook](/guides/custom-trigger.html).

### Creating a new build trigger

To setup a build trigger, click the "Create Build Trigger" button on the Builds view page and follow the instructions of the dialog. You will need to grant Quay.io access to your repositories in order to setup the trigger and your account **requires admin access on the SCM repository**.


### Manually triggering a build trigger

To trigger a build trigger manually, click the <i class="fa fa-gear"></i> icon next to the build trigger and choose "Run Now".

### Build Contexts

When building an image with docker, a directory is specified to become the build context.
This holds true for both manual builds and build triggers because the builds conducted by Quay.io are no different from running `docker build` on your own machine.
Quay.io build contexts are always the specified _subdirectory_ from the build setup and fallback to the root of the build source if none is specified.
When a build is triggered, Quay.io build workers clone the git repository to the worker machine and enter the build context before conducting a build.
For builds based on tar archives, build workers extract the archive and enter the build context.

```
example
├── .git
├── Dockerfile
├── file
└── subdir
    └── Dockerfile
```

Imagine the example above is the directory structure for a GitHub repository called "example".
If no subdirectory is specified in the build trigger setup, the build will operate in the example directory.
If `subdir` is specified to be the subdirectory in the build trigger setup, only the Dockerfile within it is visible to the build.
This means that you cannot use the `ADD` command in the Dockerfile to add `file`, because it is outside of the build context.

Unlike the Docker Hub, the Dockerfile is part of the build context on Quay. Thus, it must not appear in .dockerignore file.
