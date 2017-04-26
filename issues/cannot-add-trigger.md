---
layout: doc
sublayout: issue
title: Cannot add a build trigger
reviewed: 2015-05-28T16:29:15-04:00
frontpage: True
---

Attempting to add a [build trigger](/glossary/build-trigger.html) fails with an error message.

### You are not admin on the SCM repository

In order for Quay.io to add the webhook callback necessary for build triggers, the user granting Quay.io access to the SCM repository must have admin access on that repository.