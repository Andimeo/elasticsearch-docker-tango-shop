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
COPY models /run/models/
COPY resources /run/resources/
COPY tokenizer.properties /run/
COPY analysis-vietnamese.zip /run/

RUN \
  cd /elasticsearch && \
  bin/plugin --install analysis-vietnamese --url file:/run/analysis-vietnamese.zip

COPY start.sh /run/
# Define working directory.
WORKDIR /run

# Define default command.
CMD ["/bin/bash", "start.sh"]
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9201
EXPOSE 9202
