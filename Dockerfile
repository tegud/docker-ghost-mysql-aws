FROM ghost:0.11.8

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh \
    && npm install ghost-storage-adapter-s3 \
    && mkdir -p ./content/storage \
    && cp -r ./node_modules/ghost-storage-adapter-s3 ./content/storage/s3

COPY config.js /config-example.js

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start", "--production"]
