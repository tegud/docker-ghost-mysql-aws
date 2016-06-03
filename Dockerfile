FROM ghost:latest

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh \
  && mkdir -p /usr/src/ghost/content/storage/ghost-s3/ \
  && npm install ghost-s3-compat

COPY config.js /config-example.js
COPY storage.js /usr/src/ghost/content/storage/ghost-s3/index.js

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start", "--production"]
