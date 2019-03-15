FROM bitwalker/alpine-elixir-phoenix

RUN apk --no-cache --update add automake libtool inotify-tools autoconf python

EXPOSE 4000

ENV PORT=4000 \
    MIX_ENV="prod" \
    SECRET_KEY_BASE="RMgI4C1HSkxsEjdhtGMfwAHfyT6CKWXOgzCboJflfSm4jeAlic52io05KB6mqzc5" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LC_CTYPE="en_US.UTF-8" \
    ECTO_USE_SSL="false"


ADD . .

RUN mix do deps.get, deps.compile

# Run forderground build and phoenix digest
RUN mix compile

# Add blockscout npm deps
RUN cd apps/block_scout_web/assets/ && \
    npm install && \
    npm run deploy && \
    cd -

RUN cd apps/explorer/ && \
    npm install && \
    cd -


#RUN mix do ecto.create, ecto.migrate

# USER default

CMD ["/usr/local/bin/mix", "do", "ecto.create", "ecto.migrate" "phx.server"]
