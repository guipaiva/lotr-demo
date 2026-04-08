FROM mcr.microsoft.com/devcontainers/base:1-bookworm

ARG FLUTTER_VERSION=3.29.3

# System deps for Flutter web (no Android SDK)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip xz-utils zip libglu1-mesa ca-certificates \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter as a cached layer — only rebuilds when FLUTTER_VERSION changes
RUN curl -fsSL -o /tmp/flutter.tar.xz \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    && tar -xJf /tmp/flutter.tar.xz -C /opt \
    && rm /tmp/flutter.tar.xz \
    && chown -R vscode:vscode /opt/flutter

ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:/home/vscode/.pub-cache/bin:$PATH"

# Pre-warm Flutter web (downloads web engine artifacts into the image layer)
RUN flutter config --enable-web --no-analytics \
    && flutter precache --web \
    && flutter doctor || true

# Install Firebase CLI and flutterfire_cli globally
RUN npm install -g firebase-tools \
    && dart pub global activate flutterfire_cli
