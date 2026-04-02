# lotr_demo

A Flutter LOTR demo project.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/guipaiva/lotr-demo)

---

## 🚀 Running in GitHub Codespaces

The repository ships with a ready-to-use **Dev Container** so you can start
coding in seconds — no local Flutter install required.

### 1 – Open a Codespace

Click the badge above, or go to  
**GitHub → Code → Codespaces → Create codespace on `main`**.

The container will:
- Install Flutter (pinned version) and enable the web target.
- Run `flutter doctor -v` and `flutter pub get` automatically.

> The first build takes a few minutes while the Docker image is assembled.

### 2 – Run the Flutter web app

Inside the Codespace terminal:

```bash
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
```

GitHub Codespaces will auto-forward **port 8080**.  
Open the forwarded URL from the **Ports** tab in VS Code (or click the popup).

### 3 – Stop the server

Press <kbd>Ctrl+C</kbd> in the terminal.

### ⚠️ Limitations

| Feature | Status |
|---------|--------|
| Flutter Web | ✅ Fully supported |
| Android emulator | ❌ Not available in Codespaces (no KVM) |
| iOS simulator | ❌ Not available (macOS only) |
| Hot reload / hot restart | ✅ Works with the web target |

---

## Getting Started (local)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
