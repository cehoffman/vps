FROM cehoffman/base
MAINTAINER Chris Hoffman <cehoffman@gmail.com>

RUN add-apt-repository ppa:nginx/development
RUN apt-get install -qqy openssl nginx-full

# Copy nginx configuration
ADD conf/ /etc/nginx/

# Copy configuration for ceh domain
ADD srv/ /srv

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["nginx"]
