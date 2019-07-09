FROM node:12.6-alpine

ARG VERSION=0.3.0
ARG UID=1000
ARG GID=1000
ARG USERNAME=node

LABEL maintainer="rado.salov@gmail.com" \
    version="${VERSION}" \
    description="NodeJs image"

ENV CI Jenkins

RUN apk update && apk upgrade && \
    apk add --no-cache git python make g++ build-base libffi-dev ruby ruby-dev && \
    npm set progress false -g  && \
    npm install -g --unsafe-perm phantomjs-prebuilt && \
    npm install -g --unsafe-perm bower && \
    npm install -g --unsafe-perm grunt-cli && \
    npm install -g --unsafe-perm apidoc && \
    npm install -g --unsafe-perm @angular/cli && \
    gem install sass compass --no-ri --no-rdoc && \
    apk del build-base libffi-dev ruby-dev && \
    rm -rf /var/cache/apk/* && \
    deluser --remove-home node && \
    addgroup -S ${USERNAME} -g ${GID} && \
    adduser -S -G ${USERNAME} -u ${UID} ${USERNAME} && \
    mkdir -p /app

USER ${USERNAME}

WORKDIR /app

CMD ["npm"]
