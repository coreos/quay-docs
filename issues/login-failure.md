---
layout: doc
sublayout: issue
title: Could not login as a user
reviewed: 2017-04-28T10:08:20-04:00
---
Authentication failed

### You do not have the correct password for the user

To change your password, visit the accounts settings page, click on the user settings tab, and click on `Change password`.

### The user does not exist

To create a new user, visit the [Sign Up](https://quay.io/signin) page and fill out the form under 'Create Account'.

### Unexpected status code [301]

I am seeing this error:

```
Login against server at http://quay.io/v1/
Error: Unexpected status code [301] : <html>
<head><title>301 Moved Permanently</title></head>
<body bgcolor="white">
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.4.2</center>
</body>
</html>
```

Quay.io requires `https` at all times. Make sure to _not_ use the `http` form of the URL.

{% include login.md %}
