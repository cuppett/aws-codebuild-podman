FROM quay.io/podman/stable

ENV SUMMARY="Image which allows using podman in AWS CodeBuild." \
    DESCRIPTION="Image which allows using podman in AWS CodeBuild." \
    NAME=aws-codebuild-podman

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="AWS CodeBuild with Podman" \
      name="$NAME" \
      version="stable" \
      usage="This image can be used inside AWS CodeBuild to perform container builds." \
      maintainer="Stephen Cuppett steve@cuppett.com" \
      org.opencontainers.image.source="https://github.com/cuppett/aws-codebuild-podman" \
      org.opencontainers.image.url="ghcr.io/cuppett/aws-codebuild-podman" \
      org.opencontainers.image.documentation="https://github.com/cuppett/aws-codebuild-podman/blob/main/README.md"

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

