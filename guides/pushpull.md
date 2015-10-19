---
layout: doc
sublayout: guide
title: Pushing and Pulling Repositories
---
### Pushing a repository to Quay.io

Note: pushing to a repository requires **Repository Write Access**.

In order to push a repository to Quay.io, it must first be _tagged_ with the _quay.io_ domain and the namespace under which it will live:

```
$ sudo docker tag 0u123imageid quay.io/namespace/repository
$ sudo docker push quay.io/namespace/repository
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
