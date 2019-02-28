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
title Package with docker

Source -> [Docker] : Build image
[Docker] <- Server : Run image

note right
  Why package with docker?
  Problems resolved:
  - Different language (node, php, go,...)
  - Different deploy process (yarn serve, yarn start, rails server,... )

  Pros:
  - Deploy as: `docker run [IMAGE]`
end note
@enduml
```

```plantuml
@startuml
title Build image

Source -> [Docker]: +Dockerfile

note right
  Pros:
  - Write down manual steps into file
end note
@enduml
```

```plantuml
@startuml
title Run image

[Docker] <- Server: +docker-cli
@enduml
```

## Demo guide

Build image

```sh
# DOCKER_USER=hoanganh25991
docker build --tag hoanganh25991/todo-app:v0.1 .
docker push hoanganh25991/todo-app:v0.1
```

Run image

```sh
./setup/install-docker.sh
```

```sh
docker run --rm --detach \
  --publish 3000:3000 \
  hoanganh25991/todo-app:v0.1
```

## Nginx Reverse

```plantuml
@startuml
title Handle DNS

[App] -> [Nginx]
@enduml
```

```plantuml
@startuml
title Setup Nginx

Server -> [Nginx]: Run image
@enduml
```

Setup nginx

```sh
docker-compose up
```

Run app

```sh
DOMAIN_NAME=todo-app.xxx.nip.io
EMAIL=lehoanganh25991@gmail.com
docker run --rm --detach \
  --name todo-app \
  --env VIRTUAL_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_HOST=$DOMAIN_NAME \
  --env LETSENCRYPT_EMAIL=$EMAIL \
  hoanganh25991/todo-app:v0.1
```

Connect app to nginx

```sh
docker network connect todo-app nginx
```
