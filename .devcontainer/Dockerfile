FROM mcr.microsoft.com/devcontainers/base:1-bookworm

ARG FLUTTER_VERSION=3.41.6

# System deps + Node 20 (firebase-tools requires >=20)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip xz-utils zip libglu1-mesa ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Firebase CLI globally (system-level, any user can run it)
RUN npm install -g firebase-tools

# Install Flutter into /opt, owned by vscode
RUN curl -fsSL -o /tmp/flutter.tar.xz \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    && tar -xJf /tmp/flutter.tar.xz -C /opt \
    && rm /tmp/flutter.tar.xz \
    && chown -R vscode:vscode /opt/flutter

# Switch to vscode so Flutter/Dart commands run as the correct user
USER vscode
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:/home/vscode/.pub-cache/bin:$PATH"

RUN flutter config --enable-web --no-analytics \
    && flutter precache --web \
    && dart pub global activate flutterfire_cli

USER root
