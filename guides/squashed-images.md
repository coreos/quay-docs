---
layout: doc
sublayout: guide
title: Downloading Squashed Docker Images
reviewed: 2017-04-27T15:50:03-04:00
---

Docker images are composed of image layers which include all of the intermediary data used to reach their current state.
When iterating on a solution locally on a developer's machine, layers provide an efficient workflow.
However, there are scenarios in which the layers cease to be efficient.
For example, when deploying software to an ephemeral machine, that machine doesn't care about the whole layer history, it just needs the end state of the image.
This is why Quay.io supports _Squashed Images_.

### Downloading a Squashed Image

Navigate to the <span class="tab-reference"><i class="tab-icon fa fa-tags"></i>Tags</span> tab of a [Repository View](/guides/repo-view.html) (`https://quay.io/repository/YOURORG/YOURREPO?tab=tags`).
On left side of the table, click on the _Fetch Tag_ icon (<i class="fa fa-download"></i>) for the tag you wish to download.
A modal dialog will appear with a dropdown for specifying the desired format of the download.
Select `Squashed Docker Image` from the dropdown and then select a robot that has _read_ permission to be able to pull the repository.
Click on the `Copy Command` button and paste this command into the shell of the machine you wish to download.


### Caveats & Warnings

#### Prime the cache!

When the first pull of a squashed image occurs, the registry streams the image as it is being flattened in real time.
Afterwards, the end result is cached and served directly.
Thus, it is recommended to pull the first squashed image on a developer machine before deploying, so that all of the production machines can pull the cached result.

#### Isn't piping curl insecure?

You may be familiar with installers that pipe curl into bash (`curl website.com/installer | /bin/bash`).
These scripts are insecure because they allow arbitrary code execution.
Our script to download squashed images uses `curl` to download a tarball that is streamed into `docker load`.
This is just as secure as running `docker pull` because it never executes anything we've downloaded from the internet.
