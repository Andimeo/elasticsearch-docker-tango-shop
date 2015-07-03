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
COPY models /data/models/
COPY resources /data/resources/
COPY tokenizer.properties /data/
COPY analysis-vietnamese.zip /

RUN \
  cd /elasticsearch && \
  bin/plugin --install analysis-vietnamese --url file:/analysis-vietnamese.zip
# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
