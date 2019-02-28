# Deploy app with docker

## Follow

- Deploy app

```plantuml
@startuml
(Source) -> (Server)
@enduml
```

- Package & Run

```plantuml
@startuml
Source -> [Docker] : Build image
[Docker] <- Server : Run image

note right
  Package with docker?
  Problems resolved:
  - Different language (node, php, go,...)
  - Different deploy process (yarn serve, yarn start, rails server,... )
end note
@enduml
```

- Build image

```plantuml
@startuml
Source -> [Docker]: +Dockerfile

note right
  Pros:
  - Just write down manual steps
end note
@enduml
```

- Run image

```plantuml
@startuml
title Run image

[Docker] <- Server: +docker-cli

note right
  Pros:
  - Single command to deploy: `docker run [IMAGE]`
end note
@enduml
```

## Demo guide

- Build image

```sh
REPO=hoanganh25991
docker build --tag $REPO/todo-app:v0.1 .
docker push $REPO/todo-app:v0.1
```

- Run image

```sh
./setup/install-docker.sh
```

```sh
docker run --rm --detach \
  --publish 3000:80 \
  hoanganh25991/todo-app:v0.1
```

## Nginx Reverse

- Handle DNS

```plantuml
@startuml
Server -> [Nginx]: Run image
[App] -> [Nginx]: Attach

note right
  Automation:
  - Manage nginx (start, reload, ssl, proxy,...)
  - Write config file for each app
end note
@enduml
```

- Setup nginx

```sh
cd docker-nginx-reverse-proxy
docker-compose up
```

- Run app

```sh
DOMAIN_NAME=todo-app.SERVER_IP.nip.io
docker run --rm --detach \
  --network nginx \
  --env VIRTUAL_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_EMAIL=admin@example.com \
  hoanganh25991/todo-app:v0.1
```
