---
layout: doc
sublayout: glossary
title: Robot Accounts
---

There are many circumstances where permissions for repositories need to be shared across those repositories (continuous integration, etc).
To support this case, Quay allows the use of _robot accounts_ which can be shared by multiple repositories that are owned by a user or organization.

### Managing robot accounts

Robot accounts can be managed in the [user](/glossary/user-admin.html) or [organization](/glossary/org-admin.html)'s admin panel under the _Robot Accounts_ tab.

### Adding a robot account

Click on _Create Robot Account_ and enter a name for the account.
The username will become _namespace+accountname_ where _namespace_ is the name of the user or organiaztion.

### Authenticating with an access token

To authenticate with a robot account, either download the `.dockercfg` file from the robot account's panel or use `docker login` as described below.

### Logging in with a robot account

The following credentials are used:

**Username**: namespace+accountname (i.e. mycompany+deploy)

**Password**: (token value can be found by clicking on the robot account in the admin panel)

**Email**: (this value is ignored, any value may be used)

The following is an example taken from the command line:

```
$ docker login quay.io
Login against server at https://quay.io/v1/
Username: mycompany+myrobot
Password: ThePasswordGeneratedInTheAdminPanel
Email: any@example.com
```

### Setting permissions

Permissions can be granted to a robot account in a repository by adding that account like any other user or team.

### Deleting a robot account

A robot account can be deleted by clicking the <i class="fa fa-times"></i> icon and then clicking _Delete_.
