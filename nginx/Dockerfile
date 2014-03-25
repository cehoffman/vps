FROM cehoffman/base
MAINTAINER Chris Hoffman <cehoffman@gmail.com>

RUN apt-get install -qqy openssl nginx-light

# Copy nginx configuration
ADD conf/ /etc/nginx/

# Copy configuration for ceh domain
ADD ceh/ /srv/ceh/

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["nginx"]
