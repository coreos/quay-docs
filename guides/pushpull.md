---
layout: doc
sublayout: guide
title: Pushing and Pulling Repositories
reviewed: 2015-05-28T16:29:15-04:00
---
### Pushing a repository to Quay.io

Note: pushing to a repository requires **Repository Write Access**.

In order to push a repository to Quay.io, it must first be _tagged_ with the _quay.io_ domain and the namespace under which it will live:

```
$ sudo docker tag 0u123imageid quay.io/namespace/repository
$ sudo docker push quay.io/namespace/repository
```

### Pulling a repository from Quay.io

Note: pulling from a repository requires **Repository Read Access** for private repositories.

To pull a repository from Quay.io, run the following command:

```
$ sudo docker pull quay.io/namespace/repository
```
