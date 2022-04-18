ARG ELIXIR_VERSION=1.12.3
ARG ERLANG_VERSION=23.3.4.13
ARG ALPINE_VERSION=3.15.3

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-alpine-${ALPINE_VERSION}

RUN apk add --no-cache build-base yarn inotify-tools

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .
RUN mix do deps.get, deps.compile, ecto.setup
RUN yarn install

EXPOSE 4000

CMD ["mix", "phx.server"]