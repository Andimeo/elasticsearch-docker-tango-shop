#
# Elasticsearch Dockerfile
#
# For tango shop
#

# Pull base image.
FROM andimeo/java:6

ENV ES_PKG_NAME elasticsearch-1.1.1

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elastic.co/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz --no-check-certificate && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
COPY config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
COPY models /elasticsearch/
COPY resources /elasticsearch/
COPY tokenizer.properties /elasticsearch/
COPY analysis-vietnamese /elasticsearch/plugins
# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
