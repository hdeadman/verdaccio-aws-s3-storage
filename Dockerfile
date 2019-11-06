FROM verdaccio/verdaccio:4

# https://github.com/verdaccio/docker-examples/tree/master/amazon-s3-docker-example/v4

USER root

ENV NODE_ENV=production

## perhaps all of this is not fully required
RUN apk --no-cache add openssl ca-certificates wget && \
    apk --no-cache add g++ gcc libgcc libstdc++ linux-headers make python && \
    wget --no-check-certificate -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget --no-check-certificate -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
    apk add glibc-2.25-r0.apk

RUN npm config set registry http://registry.npmjs.org/ && npm i && npm install verdaccio-aws-s3-storage@8.3.0
USER verdaccio
