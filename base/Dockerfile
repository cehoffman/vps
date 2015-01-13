FROM ubuntu:14.10
MAINTAINER Chris Hoffman <cehoffman@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Don't need to fsync all the time due to docker
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Save space after each package install
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' > /etc/apt/apt.conf.d/no-cache

# Make ischroot always report true to stop init script callbacks
RUN rm /usr/bin/ischroot && ln -sf /bin/true /usr/bin/ischroot

# Stub initctl since upstart doesn't work inside a container
RUN dpkg-divert --local --rename --add /sbin/initctl; ln -sf /bin/true /sbin/initctl

# Make it so init scripts are not called during install
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d

# Get the latest changes
RUN apt-get -qq update && apt-get -qqy dist-upgrade && apt-get clean
RUN rm -rf /var/cache/apt/*

# Install utility packages
RUN apt-get -qqy install curl

# Make sure the base srv directory exists
RUN mkdir -p /srv
