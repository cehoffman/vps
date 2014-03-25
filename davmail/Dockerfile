FROM cehoffman/base
MAINTAINER Chris Hoffman <cehoffman@gmail.com>

RUN apt-get -qqy install openjdk-7-jre-headless libswt-gtk-3-jni
RUN mkdir -p /root/.swt/lib/linux/x86_64
RUN ln -sf /usr/lib/jni /root/.swt/lib/linux/x86_64

RUN curl -L http://downloads.sourceforge.net/project/davmail/davmail/4.4.1/davmail-linux-x86_64-4.4.1-2225.tgz | tar -zxvf -
RUN mv davmail-linux-x86_64* /srv/davmail
RUN mkdir -p /srv/davmail/log

# Copy configuration
ADD davmail.properties /srv/davmail/
ADD davmail.p12 /srv/davmail/

EXPOSE 1080
EXPOSE 1143
EXPOSE 1389
EXPOSE 1025

ENTRYPOINT ["/srv/davmail/davmail.sh"]
CMD ["/srv/davmail/davmail.properties"]
