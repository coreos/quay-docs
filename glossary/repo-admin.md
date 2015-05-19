---
layout: doc
sublayout: glossary
title: Repository Admin Panel
---
The repository admin panel provides the ability to manage all aspects of a repository.

### Access the repository admin panel

The repository admin panel can be accessed by visiting the repository's page and clicking on the blue gear icon <i class="fa fa-cog"></i> next to the repository's name.

### Permissions

The permissions tab lists all the permissions for the repository. Any user, [robot account](/robot-accounts.html), [team](/teams.html), or [access token](/access-token.html) with permissio on the repository with be listed here.

#### Defined Permissions

| Name  | Abilities                                         |
|-------|---------------------------------------------------|
| Read  | Can view the repository and _pull_ the repository |
| Write | Can view, _pull_, and _push_ the repository       |
| Admin | Can do _everything_ to the repository             |

#### Adding a permission

To add a permission, enter a username, robot account or team name into the text field and hit enter. Alternatively, click the down arrow <i class="fa fa-caret-down"></i> to see a list of teams/robot accounts.

#### Changing a permission

To change a permission for a user, robot account or team, click the permission next to that entity.

#### Deleting a permission

To delete a permission, click the <i class="fa fa-times"></i> icon and then click _Delete_

### Webhooks

The webhooks tab allows for the creation and management of [webhooks](/webhooks.html).
