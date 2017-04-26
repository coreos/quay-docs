---
layout: doc
title: Quay.io API
sublayout: api
index: true
---
The Quay.io API is a full [OAuth 2](http://oauth.net/2/), RESTful API.

**Note:** The Quay API is currently marked as version 1 and considered stable within minor versions
of Quay Enterprise. The API may (but, in practice, never has) experience breaking changes across
**major** versions of Quay Enterprise or at any time on Quay.io.

### Overview

#### API Endpoint

All APIs are accessed from the `https://quay.io/api/v1/` endpoint.

For Enterprise customers, the endpoint is `http(s)://yourdomain/api/v1/`.

#### Data format

All data is sent and received as JSON.

### API Explorer

The full list of defined methods and endpoints can be found in the [API Explorer](/api/swagger).

### Scopes

The majority of calls to the Quay.io API require a token with one or more _scopes_, which specify
the permissions granted to the token to perform some work.

<script>
  $(document).ready(function() {
      $.ajax({
        url: "https://quay.io/api/v1/discovery"
        }).done(function(f) {
            var scopes = f.authorizations.oauth2.scopes;
            $.each(scopes, function(i, item) {
                var $tr = $('<tr>').append(
                    $('<td>').text(item.scope),
                    $('<td>').text(item.title)
                ).appendTo('#scopesTable');
            });
        });
  });
</script>

<table id="scopesTable">
    <thead>
        <td>Scope</td><td>Description</td>
    </thead>
    <tr>
        <td>repo:read</td>
        <td>
            The application will be able to view and pull all repositories visible to the granting user
        </td>
    </tr>
</table>

### Applications and Tokens

#### Creating a new application

All calls to the Quay.io REST API must occur via a token created for a defined _Application_.

A new application can be created under an [Organization](/glossary/organizations.html) in the _Applications_ tab.

<img class="screenshot" src="newapp.png">

### OAuth 2 Access Tokens

All calls to API methods which are not read-only and public require the use of an OAuth 2 _access token_, specified via a header. Access tokens for the Quay.io are long-lived and do not expire.

#### Generating a Token (OAuth web flow)

If your application will be used by various users of Quay.io or the Enterprise Registry, then generating a token requires running the OAuth 2 web flow (See [Google's example](https://developers.google.com/accounts/docs/OAuth2WebServer)).

To do so, your application must make a request like so (replace `quay.io` with your domain for Enterprise Registry):

```
GET https://quay.io/oauth/authorize?response_type=token&redirect_uri={your redirect URI}&realm=realm&client_id={application client ID}&scope={comma delineated set of scopes to request}
```

Once the user has approved the permissions for your application, the browser will load the specified redirect URI with the access token appended like so:

```
http://example.com/the/redirect/uri/path#access_token={created access token}
```

This access token can then be saved to make API requests.


#### Generating a Token (for internal application use)

**Note:** The generated token will be created on behalf of the **currently logged in user**.

If the API call will be conducted by an internal application, an access token can be generated simply by clicking on the _Generate Token_ tab under the application, choosing scopes, and then clicking the _Generate Access Token_ button. After conducting the OAuth flow for the current account, the newly generated token will be displayed.

<img class="screenshot" src="generate-token.png" style="width: 700px">

### Making an API request

API requests are made by executing the documented HTTP verb (GET, POST, PUT or DELETE) against the API endpoint URL, with an Authorization header **containing the access token** and (if necessary) body content in JSON form.

#### Example: Find all repositories belonging to the token's user

```
Authorization: Bearer AccessTokenGoesHere
GET https://quay.io/api/v1/repository?private=true&public=false
```


#### Example: Adding a team permission to a repository

```
Authorization: Bearer AccessTokenGoesHere
PUT https://quay.io/api/v1/repository/some/repo/permissions/team/someteam

{
  "role": "read"
}
```

### Pulling and Pushing using an access token

OAuth 2 access tokens granted by Quay.io applications can invoke `docker pull` and `docker push` on behalf of the user if they have the `repo:read` and `repo:write` scopes (respectively).

To login, the `docker login` command can be used with the username `$oauthtoken` and the access token as the password:

```
$ docker login quay.io
Username: $oauthtoken
Password: ThisIsTheAccessToken
Email: ignore@this.com
```
