FROM registry.fedoraproject.org/fedora:34

ENV SUMMARY="Image which allows using podman in AWS CodeBuild." \
    DESCRIPTION="Image which allows using podman in AWS CodeBuild." \
    NAME=aws-codebuild-podman \
    VERSION=34

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="AWS CodeBuild with Podman" \
      com.redhat.component="$NAME" \
      name="$FGC/$NAME" \
      version="$VERSION" \
      usage="This image can be used inside AWS CodeBuild to perform container builds." \
      maintainer="Stephen Cuppett <scuppett@redhat.com>"

# Installing OS support
RUN set -ex; \
    \
    dnf -y install \
        awscli \
        podman \
    ; \
    dnf -y clean all; \
    rm -rf /var/cache/dnf

# Preparing container tools support for CodeBuild kernels
RUN set -ex; \
    sed -i 's/,metacopy\=on//g' /etc/containers/storage.conf; \
    sed -i 's/\#mount_program/mount_program/g' /etc/containers/storage.conf; \
    echo "[engine]" > /etc/containers/containers.conf; \
    echo "events_logger = \"file\"" >> /etc/containers/containers.conf;
