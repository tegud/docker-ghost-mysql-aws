FROM ghost:0.11.8-alpine

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh \
  && mkdir -p /usr/src/ghost/content/storage \
  && npm install ghost-s3-compat
  && cp -r /usr/src/ghost/node_modules/ghost-s3-compat /usr/src/ghost/content/storage/ghost-s3-compat

COPY config.js /config-example.js

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start", "--production"]
