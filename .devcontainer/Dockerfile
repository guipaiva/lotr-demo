# Pinned Debian Bookworm base with the non-root "vscode" user provided
# by the Microsoft devcontainers base image.
FROM mcr.microsoft.com/devcontainers/base:1-bookworm

# ── Flutter version to install ────────────────────────────────────────────────
# To upgrade, change FLUTTER_VERSION and rebuild the Codespace.
ARG FLUTTER_VERSION=3.29.2
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

# ── System dependencies required by Flutter / web tooling ────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
        xz-utils \
        libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# ── Install Flutter SDK (pinned tag, shallow clone for speed) ─────────────────
RUN git clone --depth 1 --branch "${FLUTTER_VERSION}" \
        https://github.com/flutter/flutter.git "${FLUTTER_HOME}" \
    # Pre-cache web artifacts only (no Android/iOS SDK in Codespaces)
    && "${FLUTTER_HOME}/bin/flutter" config --enable-web \
    && "${FLUTTER_HOME}/bin/flutter" precache --web \
    # Allow the non-root "vscode" user to own and write the SDK directory
    && chown -R vscode:vscode "${FLUTTER_HOME}"
