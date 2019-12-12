# proxy_apache
FROM openshift/httpd:2.4

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Mark Cheung <mchehung@redhat.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building Web base application deployed in Apache as front end.  The Apache also forward the request at the backend via Apache proxy module" \
      io.k8s.display-name="Proxy Apache" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# This label is used to categorize this image as a builder image in the
# OpenShift web console.
LABEL io.openshift.tags="builder, httpd, httpd24, httpd-proxy"

# Add the proxy instruction to the httpd.conf
COPY ./proxy-directive.conf /etc/httpd/conf.modules.d
RUN cat /etc/httpd/conf.modules.d/00-proxy.conf /etc/httpd/conf.modules.d/proxy-directive.conf > /etc/httpd/conf.modules.d/01-proxy.conf && \
    rm /etc/httpd/conf.modules.d/00-proxy.conf
