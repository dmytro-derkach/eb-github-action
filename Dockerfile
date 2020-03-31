FROM debian:latest

WORKDIR /app

LABEL version="1.0.0"
LABEL repository="https://github.com/dmytro-derkach/eb-github-action"
LABEL homepage="https://github.com/dmytro-derkach/eb-github-action"
LABEL maintainer="Dmytro Derkach"

LABEL "com.github.actions.name"="EB github action"
LABEL "com.github.actions.description"="Deploy eb app to aws"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="red"

RUN apt update && apt install -y awscli

COPY deploy.sh deploy.sh
RUN chmod +x deploy.sh

ENTRYPOINT /app/deploy.sh
