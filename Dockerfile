#
# Elasticsearch Dockerfile
#
# For tango shop
#

# Pull base image.
FROM cloudesire/java:6

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
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
