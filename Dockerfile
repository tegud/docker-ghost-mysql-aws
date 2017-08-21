FROM node:6

RUN groupadd user && useradd --create-home --home-dir /home/user -g user user

ENV GHOST_SOURCE /usr/src/ghost
WORKDIR $GHOST_SOURCE

ENV GHOST_VERSION 0.11.10

RUN set -ex; \
	\
	buildDeps=' \
		gcc \
		make \
		python \
		unzip \
	'; \
	apt-get update; \
	apt-get install -y $buildDeps --no-install-recommends; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O ghost.zip "https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip"; \
	unzip ghost.zip; \
	\
	npm install --production; \
	\
	rm ghost.zip;

ENV GHOST_CONTENT /var/lib/ghost
RUN mkdir -p "$GHOST_CONTENT" \
	&& chown -R user:user "$GHOST_CONTENT" \
# Ghost expects "config.js" to be in $GHOST_SOURCE, but it's more useful for
# image users to manage that as part of their $GHOST_CONTENT volume, so we
# symlink.
	&& ln -s "$GHOST_CONTENT/config.js" "$GHOST_SOURCE/config.js"
VOLUME $GHOST_CONTENT

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

EXPOSE 2368

WORKDIR /usr/src/ghost/

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh \
  && mkdir -p /usr/src/ghost/content/storage \
  && npm install ghost-google-cloud-storage

COPY config.js /config-example.js
COPY storage.js /usr/src/ghost/content/storage/gcloud/index.js

RUN npm install gcloud util bluebird

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start", "--production"]
