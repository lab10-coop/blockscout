FROM bitwalker/alpine-elixir-phoenix:latest

RUN apk --no-cache --update add automake libtool inotify-tools autoconf

EXPOSE 4000

ENV PORT=4000 \
    MIX_ENV="prod" \
    SECRET_KEY_BASE="RMgI4C1HSkxsEjdhtGMfwAHfyT6CKWXOgzCboJflfSm4jeAlic52io05KB6mqzc5"

ADD ./scripts /home/blockscout/

CMD /bin/sh