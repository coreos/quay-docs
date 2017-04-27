---
layout: doc
sublayout: guide
title: Pushing and Pulling Repositories
reviewed: 2017-04-27T16:29:15-04:00
---
### Pushing a repository to Quay.io

Note: pushing to a repository requires **Repository Write Access**.
Note: you should have a name for the image before you push it

In order to push a repository to Quay.io, run the following command:

```
$ sudo docker push quay.io/namespace/repository:tag
```

### Pulling a repository from Quay.io

Note: pulling from a repository requires **Repository Read Access** for private repositories.

To pull a repository from Quay.io, run the following command:

```
$ sudo docker pull quay.io/namespace/repository
```
