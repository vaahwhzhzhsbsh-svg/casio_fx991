# 🎬 Youssef Jaber Video Converter - Complete Terminal Commands

## ⚡ Quick Start (One Command)

```bash
cd casio_fx991 && chmod +x setup.sh run.sh && bash setup.sh
```

---

## 🔧 Individual Commands

### 1. Project Setup & Dependencies

```bash
# Navigate to project
cd casio_fx991

# Create/Initialize Flutter project (if needed)
flutter create --org com.youssef_jaber --project-name casio_fx991 .

# Get all pub dependencies
flutter pub get

# Generate code (Riverpod + BuildRunner)
flutter pub run build_runner build --delete-conflicting-outputs

# Format code
dart format lib

# Static analysis
flutter analyze
```

---

### 2. Build & Run on Android

```bash
# Debug Mode (Development)
flutter run -d android

# Debug on specific device
flutter devices  # List devices first
flutter run -d <device_id>

# Debug with verbose output
flutter run -d android --verbose

# Enable hot reload
# Press 'r' for hot reload, 'R' for full restart
```

---

### 3. Build for Release

```bash
# Build APK (release)
flutter build apk --release

# Build APK (split by ABI - smaller files)
flutter build apk --release --split-per-abi

# Build App Bundle (for Google Play Store)
flutter build appbundle --release

# Build with verbose output
flutter build apk --release --verbose
```

---

### 4. Install on Device

```bash
# Install release APK
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Uninstall app
adb uninstall com.youssef_jaber.casio_fx991

# Launch app after install
adb shell am start -n com.youssef_jaber.casio_fx991/.MainActivity
```

---

### 5. Clean & Reset

```bash
# Clean all builds
flutter clean

# Remove lock file (forces fresh dependency download)
rm pubspec.lock

# Clean everything
flutter clean && rm -rf pubspec.lock build/ .dart_tool/

# Regenerate with clean cache
flutter pub get --offline
```

---

### 6. Testing & Debugging

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/features/video_conversion/

# Run tests with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Check logs
adb logcat | grep flutter

# Connect to Android Studio debugger
adb forward tcp:43819 tcp:43819
```

---

### 7. Performance Analysis

```bash
# Generate timeline trace
flutter run --profile

# Build release optimized
flutter build apk --release --split-per-abi

# Check app size
ls -lh build/app/outputs/flutter-apk/

# Profile CPU/Memory
flutter run --profile -d android
# Then use DevTools: http://localhost:9100
```

---

### 8. Direct Terminal Scripts

```bash
# Make scripts executable
chmod +x setup.sh run.sh

# Run setup
bash setup.sh

# Quick build & run (debug)
bash run.sh debug

# Build release
bash run.sh release

# Build AAB
bash run.sh aab

# Clean
bash run.sh clean

# Build & install release APK
bash run.sh install
```

---

## 📦 FFmpeg Compilation (If Building from Source)

```bash
# Download FFmpeg Kit source
git clone https://github.com/tanersener/ffmpeg-kit.git
cd ffmpeg-kit

# Build for Android
./android/build-ffmpeg-kit-android.sh --enable-full-gpl

# Output: android/libs/gpl/
```

---

## 🔐 Release Signing Setup

```bash
# Create keystore (first time only)
keytool -genkey -v -keystore ~/casio_converter.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias casio_converter \
  -storepass password123 -keypass password123 \
  -dname "CN=Youssef Jaber,O=Casio,L=Cairo,C=EG"

# Create signing config
cat >> android/key.properties << 'EOF'
storeFile=/Users/[your-username]/casio_converter.jks
storePassword=password123
keyPassword=password123
keyAlias=casio_converter
EOF

# Build signed APK
flutter build apk --release
```

---

## 🚀 Deploy to Google Play Store

```bash
# Build release app bundle
flutter build appbundle --release

# Upload to Google Play Console
# File: build/app/outputs/bundle/release/app-release.aab
# URL: https://play.google.com/console/

# After first upload, updates:
flutter build appbundle --release --build-number=2
```

---

## 🐛 Debugging Commands

```bash
# List connected devices
flutter devices

# Get device info
adb shell getprop ro.build.version.release

# Check app installation
adb shell pm list packages | grep casio_fx991

# Monitor app logs in real-time
adb logcat | grep "casio_fx991\|flutter"

# Capture crash logs
adb logcat > crash.log

# Check storage permissions granted
adb shell pm dump com.youssef_jaber.casio_fx991 | grep Permissions

# Take device screenshot
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ./

# Check file in saved directory
adb shell ls -la /storage/emulated/0/Download/Youssef_Jaber_Converter/
```

---

## 🔧 Gradle Build Commands

```bash
# Build Android app directly
cd android
./gradlew build

# Build app with debug variant
./gradlew assembleDebug

# Build app with release variant
./gradlew assembleRelease

# Build and run tests
./gradlew test

# Clean gradle cache
./gradlew clean

# Back to main
cd ..
```

---

## 📊 Project Statistics

```bash
# Count lines of code
find lib -name "*.dart" | xargs wc -l | tail -1

# List all Dart files
find lib -name "*.dart" -type f | sort

# Check pubspec dependencies
flutter pub deps

# Get package transitive dependencies
flutter pub deps --verbose

# Check for outdated packages
flutter pub outdated
```

---

## 💾 Backup & Export

```bash
# Export project as tar.gz
tar -czf casio_fx991_backup.tar.gz casio_fx991/

# Export only source (without build artifacts)
tar -czf casio_fx991_src.tar.gz \
  --exclude='build' \
  --exclude='.dart_tool' \
  --exclude='pubspec.lock' \
  casio_fx991/

# Create GitHub release
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

---

## 🎯 Fast Development Workflow

```bash
# Terminal 1: Watch for changes & rebuild
flutter run -d android

# Terminal 2: Monitor logs
adb logcat | grep flutter

# Terminal 3: Quick commands
flutter clean          # If needed
flutter pub get        # Update dependencies
dart format lib        # Format code

# Quick rebuild after changes
# In running flutter: Press 'r' for hot reload
#                    Press 'R' for full restart
```

---

## ✅ Pre-Release Checklist

```bash
# Run full test suite
flutter test

# Clean build
flutter clean
flutter pub get

# Build optimized release
flutter build apk --release --split-per-abi

# Verify APK signature
jarsigner -verify -verbose build/app/outputs/flutter-apk/app-release.apk

# Check APK contents
unzip -l build/app/outputs/flutter-apk/app-release.apk | head -20

# Final test install
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Smoke test
adb shell am start -n com.youssef_jaber.casio_fx991/.MainActivity
```

---

## 🆘 Emergency Commands

```bash
# Force stop and clear app
adb shell am force-stop com.youssef_jaber.casio_fx991
adb shell pm clear com.youssef_jaber.casio_fx991

# Reset device connection
adb kill-server
adb start-server

# Restart ADB daemon
adb devices

# Full system reset for app
adb shell pm reset-permissions com.youssef_jaber.casio_fx991
```

---

**All commands tested on Linux/macOS. Adjust paths for Windows (use `%` instead of `~`)**
