---
layout: doc
sublayout: glossary
title: Webhooks
---
A repository can have one or more _push webhooks_ setup, which will be invoked whenever _a successful push occurs_.

### Managing webhooks

Webhooks can be managed from the repository's [admin page](/repo-admin.html).

### Webhook call format

A webhook will be invoked as an _HTTP POST_ to the specified URL, with a JSON body describing the push:

```json
{
  "pushed_image_count": 2,
  "name": "ubuntu",
  "repository":"devtable/ubuntu",
  "docker_url": "quay.io/devtable/ubuntu",
  "updated_tags": {
    "latest": "b750fe79269d2ec9a3c593ef05b4332b1d1a02a62b4accb2c21d589ff2f5f2dc"
  },
  "namespace": "devtable",
  "visibility": "private",
  "homepage": "https://quay.io/repository/devtable/ubuntu"
}
```
