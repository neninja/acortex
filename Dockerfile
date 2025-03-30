FROM elixir:1.18.3-alpine

RUN apk add --no-cache build-base && apk add inotify-tools && apk add inotify-tools git

# instalando o gerenciar de pacotes do elixir
RUN mix local.hex --force && \
    mix archive.install --force hex phx_new 1.7.21 && \
    mix local.rebar --force

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
