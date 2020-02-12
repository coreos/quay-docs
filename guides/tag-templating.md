---
layout: doc
sublayout: guide
title: Tag Templating
---

## Tag Templating

A tag template can be specified to provide custom tagging for builds in Quay. The template is a JSON template expression pulling the information from the build manifest.

### Build manifest schema

The schema for build manifests can be found [here](https://github.com/quay/quay/blob/master/buildtrigger/basehandler.py#L81)
