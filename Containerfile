FROM registry.fedoraproject.org/fedora:39

ENV SUMMARY="Image which allows using podman in AWS CodeBuild." \
    DESCRIPTION="Image which allows using podman in AWS CodeBuild." \
    NAME=aws-codebuild-podman \
    VERSION=39

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="AWS CodeBuild with Podman" \
      com.redhat.component="$NAME" \
      name="$FGC/$NAME" \
      version="$VERSION" \
      usage="This image can be used inside AWS CodeBuild to perform container builds." \
      maintainer="Stephen Cuppett <steve@cuppett.com>" \
      org.opencontainers.image.source="https://github.com/cuppett/aws-codebuild-podman"

# Installing OS support
RUN set -ex; \
    dnf -y install \
        awscli \
        golang \
        podman \
        podman-docker \
        make \
        source-to-image \
    ; \
    dnf -y clean all; \
    rm -rf /var/cache/dnf

# Preparing container tools support for CodeBuild kernels
RUN set -ex; \
    touch /etc/containers/nodocker; \
    echo "[engine]" > /etc/containers/containers.conf; \
    echo "image_default_format = \"v2s2\"" >> /etc/containers/containers.conf; \
    echo "events_logger = \"file\"" >> /etc/containers/containers.conf; \
    echo "cgroup_manager = \"cgroupfs\"" >> /etc/containers/containers.conf;

COPY storage.conf /etc/containers/storage.conf
