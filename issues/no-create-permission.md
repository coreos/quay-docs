---
layout: doc
sublayout: issue
title: Cannot create new repository
reviewed: 2017-04-26T17:30:00-04:00
---
The user or [robot account](/glossary/robot-accounts.html) does not have permission to create new repositories in this namespace.

### I do not belong to an organization and this is not my namespace

A user can only create repositories in its **own** namespace. For example, the user `devtable` can only create repositories named `devtable/(repo name)`.

### I'm trying to use a robot account as my repository's namespace

A user can only create repositories in its **own** namespace. Robot accounts cannot create be used as the namespace for repositories.

### I'm trying to use a robot account to create a repository

[Robot accounts](/glossary/robot-accounts.html), despite living under your username or organization name, do not normally possess the ability to create repositories in that namespace for security reasons.

For a user-owned robot account, a repository must be created by the user first, and then permissions granted to the robot account in the [repository permissions table](/guides/repo-permissions.html) to pull and/or push to that repository.

For an organization-owned robot account, a robot account can be granted permission to create repositories if placed under a [team](/glossary/team.html) with the `creator` permission. Otherwise, a robot account must be granted individual permissions.

### My account is part of an organization

Check with your organization administrator to ensure that your user or robot account is part of a [team](/glossary/teams.html) with the `creator` permission.
