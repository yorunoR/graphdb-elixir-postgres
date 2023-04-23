FROM node:18.12-alpine

WORKDIR /mgt

COPY package.json /mgt/package.json

RUN apk --no-cache --virtual build-dependencies add \
    && yarn install \
    && apk del build-dependencies
