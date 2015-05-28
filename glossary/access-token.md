---
layout: doc
sublayout: glossary
title: Access Tokens
---

### NOTE: Access tokens are currently **deprecated** and should not be used. [Robot Accounts](/glossary/robot-accounts.html) are their replacement.

For per-repository token authentication, Quay allows the use of _access tokens_ which can be created on a repository and have read and/or write permissions, without any passwords.

### Managing access tokens

Access tokens can be managed in the [repository view](/guides/repo-view.html).

### Authenticating with an access token

To authenticate with an access token, either download the `.dockercfg` file from the access token's panel OR use `docker login` as described below.

### Logging in with an access token

The following credentials are used:

**Username**: $token

**Password**: (token value can be found by clicking on the token)

**Email**: (this value is ignored, any value may be used)

The following is an example taken from the command line:

```
$ sudo docker login quay.io
Login against server at https://quay.io/v1/
Username: $token
Password: (token value from the token)
Email: any@example.com
```

### Setting permissions

A token's permissions can be changed by clicking the field to the right of the token

### Deleting an access token

An access token can be deleted by clicking the <i class="fa fa-times"></i> icon and then clicking _Delete_.
