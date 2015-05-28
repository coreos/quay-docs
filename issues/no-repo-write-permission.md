---
layout: doc
sublayout: issue
title: Cannot modify repository
---
The user, [robot account](/glossary/robot-accounts.html), or [access token](/glossary/access-token.html) does not have permission to modify the repository.

### An access token or user does not have at least _write_ permission on the repository

Check the permissions for the user, robot account or token in the repository permissions table](/guides/repo-permissions.html) and make sure it is listed with `write` or `admin`

### You are authenticated and have _write_/_admin_ permission but still see the error

See [I'm authorized but I'm still getting 403s](/issues/auth-failure.html).
