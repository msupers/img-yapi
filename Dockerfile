FROM node:12-alpine as builder

RUN apk add --no-cache git python make openssl tar gcc wget 

COPY yapi.tar.gz /home


RUN cd /home &&  tar -zvxf yapi.tar.gz && mkdir /api &&  mv yapi-1.9.1 /api/vendors

#RUN cd /home && tar zxvf yapi.tar.gz && mkdir /api && mv /home/yapi-1.8.0 /api/vendors

RUN cd /api/vendors && \
    npm install --production --registry http://registry.npmjs.org

FROM node:12-alpine

MAINTAINER msupers@163.com

ENV TZ="Asia/Shanghai" HOME="/"

WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors

COPY config.json /api/

EXPOSE 3000

ENTRYPOINT ["node"]


