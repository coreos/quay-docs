---
layout: doc
sublayout: issue
title: Cannot access private repositories using EC2 Container Service
frontpage: True
---
Authentication is failing while attempting to use Amazon ECS (EC2 Container Service)

### Authentication configuration in ecs.config is missing

In order for ECS to pull down docker images, the following needs to be in the ECS configuration file located at `/etc/ecs/ecs.conf`:

```
ECS_ENGINE_AUTH_TYPE=dockercfg
ECS_ENGINE_AUTH_DATA={"quay.io": {"auth": "YOURAUTHTOKENFROMDOCKERCFG", "email": "user@example.com"}}
```

`ECS_ENGINE_AUTH_DATA` is the contents of the `auths` atttribute in `.docker/config.json` starting at Docker version `1.7.0` or the contents of `.dockercfg` before that.

After updating this file, the ECS service must be restarted for the change to propagate.

See [AWS documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/private-auth.html) for more information.
