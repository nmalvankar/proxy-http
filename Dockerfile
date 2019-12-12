# proxy_apache
FROM registry.access.redhat.com/rhscl/httpd-24-rhel7

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
RUN cat /etc/httpd/conf.modules.d/00-proxy.conf /etc/httpd/conf.modules.d/proxy-directive.conf > /etc/httpd/conf.modules.d/01-proxy.conf
RUN rm /etc/httpd/conf.modules.d/00-proxy.conf


# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
#COPY ./s2i/bin/assemble /usr/libexec/s2i/assemble

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
#RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
#USER 1001

# TODO: Set the default port for applications built using this image
#EXPOSE 8080

# TODO: Set the default CMD for the image
#CMD ["/usr/libexec/s2i/usage"]
