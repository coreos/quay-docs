---
layout: doc
sublayout: guide
title: GitHub Read-Only Build Triggers
reviewed: 2017-04-27T13:38:39-04:00
---

GitHub-based build triggers are by default set up with read and write access to a user's source repositories. At this time GitHub does not provide a way to create webhooks without granting these permissions.

However, users can [revoke their granted GitHub read/write permissions](https://help.github.com/articles/keeping-your-ssh-keys-and-application-access-tokens-safe/) _after a trigger has been setup_ without breaking the Quay.io build trigger.

### Setting up GitHub Read-Only Build Trigger

1. Follow the steps to create a build trigger by selecting GitHub under the `Create Build Trigger` button on the repository's Build tab.
2. In GitHub, [revoke the newly granted read/write permissions](https://help.github.com/articles/keeping-your-ssh-keys-and-application-access-tokens-safe/) for the new Quay.io integration.
3. Re-add the deploy key for the trigger to the GitHub repository. You can find the deploy key by clicking on the gear icon (<i class="fa fa-gear"></i>) next to the trigger on Quay.io and choosing "View Credentials".

:warning: The "Run Trigger Now" command on the build trigger requires read access to the GitHub repository and will not work if these permissions have been revoked. This is because it needs to look up the GitHub repository's HEAD commit ID to run the trigger.
