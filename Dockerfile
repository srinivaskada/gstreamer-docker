# GStreamer base image
FROM restreamio/gstreamer:latest-dev as base
RUN apt-get -y update
RUN apt-get install -y ca-certificates curl gnupg build-essential git gobject-introspection libgirepository1.0-dev libcairo2 libcairo2-dev gir1.2-gstreamer-1.0
RUN apt-get update
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=16
ENV GI_TYPELIB_PATH=/usr/lib/x86_64-linux-gnu/girepository-1.0/
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get -y install nodejs

# Application image
FROM base as app-gstreamer
WORKDIR /app
COPY package.json .
COPY package-lock.json .
COPY docker-entrypoint.sh .
COPY ./src ./src
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN npm install
RUN npm install node-gtk
RUN ["chmod", "+x", "docker-entrypoint.sh"]l
ENTRYPOINT ["sh", "docker-entrypoint.sh"]

