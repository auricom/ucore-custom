### 1. BUILD ARGS
## IMAGE_NAME arg can be anything from ublue upstream: silverblue, kinoite, sericea, vauxite, mate, lxqt, base
ARG IMAGE_NAME="${IMAGE_NAME:-ucore-minimal}"

## FEDORA_VERSION arg must be a version built by ublue: 39 or 40 as of today (stable for ucore)
ARG IMAGE_TAG="${IMAGE_TAG:-stable-zfs}"

### 2. SOURCE IMAGE
## this is a standard Containerfile FROM using the build ARGs above to select the right upstream image
FROM ghcr.io/ublue-os/${IMAGE_NAME}:${IMAGE_TAG}
ENV UCORE_UPSTREAM_IMAGE_TAG=${IMAGE_TAG}

COPY usr /usr
COPY scripts /tmp/
COPY .sops.yaml /usr/share/sops/

### 3. MODIFICATIONS
## make modifications desired in your image and install packages here, a few examples follow
RUN /tmp/install.sh && \
    /tmp/post-install.sh && \
    ostree container commit