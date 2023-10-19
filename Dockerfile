FROM node:lts-alpine

RUN set -ex && mkdir /app
ENV SIGN_CERT /app/server.crt
ENV SIGN_KEY /app/server.key
ENV NODE_ENV production

COPY . /app
WORKDIR /app

RUN apk add --no-cache python3 youtube-dl \
    && wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yarn install

EXPOSE 8080 8081

ENTRYPOINT ["node", "src/app.js"]
