FROM quay.io/podman/stable

ENV SUMMARY="Image which allows using podman in AWS CodeBuild." \
    DESCRIPTION="Image which allows using podman in AWS CodeBuild." \
    NAME=aws-codebuild-podman

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
    dnf -y update; \
    dnf -y install \
        awscli \
        golang \
        podman-docker \
        make \
        source-to-image \
    ; \
    dnf -y clean all; \
    rm -rf /var/cache/dnf

