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

You can also specify an optional version label or a tag to your image by using `quay.io/namespace/repository:TAG`. By default, `latest` is used.

### Pulling a repository from Quay.io

Note: pulling from a repository requires **Repository Read Access** for private repositories.

To pull a repository from Quay.io, run the following command:

```
$ sudo docker pull quay.io/namespace/repository
```

The command above pulls the image _tagged_ with `latest`; you may pull specific [Tags](/guides/tag-operations.html) by appending `:TAG`, exactly as introduced in the _Pushing_ section. If you are using Docker 1.6 or higher, you can also use the _digest_ of an image to identify it, which is a content-addressable identifier that remains the same as long as the input used to generate the image is unchanged:

```
$ sudo docker pull quay.io/namespace/repository@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
```

To get digest values, simply list images with the `--digests` flag:

```
$ docker images --digests
```

Note that `docker pull` and `docker push` also output digests.
