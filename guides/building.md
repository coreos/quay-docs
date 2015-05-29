---
layout: doc
sublayout: guide
title: Building Dockerfiles
---

Quay.io supports the ability to build [Dockerfiles](http://docs.docker.com/reference/builder/) on our build fleet, and push the resulting image to the repository.

## Viewing and managing builds

Repository Builds can be viewed and managed by clicking the <span class="tab-reference"><i class="tab-icon fa fa-tasks"></i>Builds</span> tab in the [Repository View](/guides/repo-view.html).

## Manually starting a build

To manually start a repository build, click the `+` icon in the top right of the header on any repository page and choose 'New Dockerfile Build'. A `Dockerfile` or a `.tar.gz` can be uploaded for the build.

## Build Triggers

Repository builds can also be automatically triggered by events such as a push to an SCM (GitHub, BitBucket or GitLab) or via [a call to a webhook](/guides/custom-trigger.html).

### Creating a new build trigger

To setup a build trigger, click the "Create Build Trigger" button on the Builds view page and follow the instructions of the dialog. You will need to grant Quay.io access to your repositories in order to setup the trigger and your account **requires admin access on the SCM repository**.


### Manually triggering a build trigger

To trigger a build trigger manually, click the <i class="fa fa-gear"></i> icon next to the build trigger and choose "Run Now".