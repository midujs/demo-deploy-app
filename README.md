# Deploy app with docker

## Follow

```plantuml
@startuml
title Deploy app

(Source) -> (Server)
@enduml
```

```plantuml
@startuml
title Package app

Source -> [Docker] : Build image
[Docker] <- Server : Run image
@enduml
```

```sh
Package with docker?
Problems resolved:
- Different language (node, php, go,...)
- Different deploy process (yarn serve, yarn start, rails server,... )
```

```plantuml
@startuml
title Build image

Source -> [Docker]: +Dockerfile
@enduml
```

```sh
Pros:
- Just write down manual steps
```

```plantuml
@startuml
title Run image

[Docker] <- Server: +docker-cli
@enduml
```

```sh
Pros:
- Deploy with single cmd: `docker run [IMAGE]`
```

## Demo guide

Build image

```sh
REPO=hoanganh25991
docker build --tag $REPO/todo-app:v0.1 .
docker push $REPO/todo-app:v0.1
```

Run image

```sh
./setup/install-docker.sh
```

```sh
docker run --rm --detach \
  --publish 3000:80 \
  hoanganh25991/todo-app:v0.1
```

## Nginx Reverse

```plantuml
@startuml
title Handle DNS
Server -> [Nginx]: Run image

[App] -> [Nginx]: Let nginx redirect to app
@enduml
```

Setup nginx

```sh
cd docker-nginx-reverse-proxy
docker-compose up
```

Run app

```sh
DOMAIN_NAME=todo-app.SERVER_IP.nip.io
docker run --rm --detach \
  --network nginx \
  --env VIRTUAL_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_EMAIL=admin@example.com \
  hoanganh25991/todo-app:v0.1
```
