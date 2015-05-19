---
layout: doc
sublayout: guide
title: Creating a repository
---
There are two ways to create a repository in Quay.io: via a `docker push` and via the Quay.io UI.

### Creating a repository via the UI

To create a repository in the Quay.io UI, click the `+` icon in the top right of the header on any Quay.io page, choose a namespace (only applies to organizations), enter a repository name and then click the 'Create Repository' button. The repository will start out empty unless a `Dockerfile` is uploaded as well.

### Creating a repository via docker

First, tag the repository:

```
$ sudo docker tag 0u123imageid quay.io/namespace/repo_name
```

Then push to Quay.io:

```
$ sudo docker push quay.io/namespace/repo_name
```
