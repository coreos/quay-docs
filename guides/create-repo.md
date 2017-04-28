---
layout: doc
sublayout: guide
title: Creating a repository
reviewed: 2017-04-27T14:31:38-04:00
---
There are two ways to create a repository in Quay.io: via a `docker push` and via the Quay.io UI.

### Creating an image repository via the UI

To create a repository in the Quay.io UI, click the `+` icon in the top right of the header on any Quay.io page and choose 'New Repository'. Select 'Container Image Repository' on the next page, choose a namespace (only applies to organizations), enter a repository name and then click the 'Create Repository' button. The repository will start out empty unless a `Dockerfile` is uploaded as well.

### Creating an image repository via docker

First, tag the repository:

```
$ docker tag 0u123imageid quay.io/namespace/repo_name
```

Then push to Quay.io:

```
$ docker push quay.io/namespace/repo_name
```

### Creating an application repository via the UI

To create a repository in the Quay.io UI, click the `+` icon in the top right of the header on any Quay.io page and choose 'New Repository'. Select 'Application Repository' on the next page, choose a namespace (only applies to organizations), enter a repository name and then click the 'Create Repository' button. The repository will start out empty.

