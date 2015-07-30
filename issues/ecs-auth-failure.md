---
layout: doc
sublayout: issue
title: Cannot access private repositories using EC2 Container Service
---
Authentication is failing while attempting to use Amazon ECS (EC2 Container Service)

### Authentication configuration in ecs.config is missing

In order for ECS to pull down docker images, the following in needs to be in the ECS configuration file located at `/etc/ecs/ecs.conf`:

```
ECS_ENGINE_AUTH_TYPE=docker
ECS_ENGINE_AUTH_DATA={"quay.io": {"auth": "YOURAUTHTOKENFROMDOCKERCFG","email": "user@example.com"}}
```

`ECS_ENGINE_AUTH_DATA` is the contents of a .dockercfg file which is usually used for docker authentication.

After updating this file, the ECS service must be restarted for the change to propagate.
