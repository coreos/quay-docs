---
layout: doc
sublayout: guide
title: GitHub Read-Only Build Triggers
---

GitHub-based build triggers are by default setup with read and write access to a user's source repositories due to GitHub's limited permissions model.

Users can [revoke their granted GitHub read/write permissions](https://help.github.com/articles/keeping-your-ssh-keys-and-application-access-tokens-safe/) _after a trigger has been setup_ and Quay.io will still be able to operate that build trigger.

**Note:** The deploy key for the trigger will have to be re-added to the GitHub repository. The deploy key can be seen by clicing on the gear icon (<i class="fa fa-gear"></i>) next to the trigger and choosing "View Credentials".

**Note:** The "Run Trigger Now" command on the build trigger will not function in this setup, as it requires access to lookup the GitHub repository's HEAD commit ID.