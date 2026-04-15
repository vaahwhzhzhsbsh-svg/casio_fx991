#!/bin/bash

# 🚀 MAGIC QUICK COMMANDS - Copy & Paste

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 1: First Time Setup
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

cd /workspaces/casio_fx991

# Option A: Automatic Setup (Recommended)
bash setup.sh

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 2: Run on Device
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Debug (Fast Development)
bash run.sh debug

# Release (Production Build)
bash run.sh release

# Auto-Install Release
bash run.sh install

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 3: Clean & Reset
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Full Clean
bash run.sh clean

# Fresh Start
flutter clean && rm -rf pubspec.lock build/ .dart_tool/
flutter pub get

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 4: Manual Build Commands
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run on connected device
flutter run -d android

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 5: Device Management
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# List all connected devices
flutter devices

# Install release APK manually
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Uninstall app
adb uninstall com.youssef_jaber.casio_fx991

# Launch app
adb shell am start -n com.youssef_jaber.casio_fx991/.MainActivity

# View logs
adb logcat | grep flutter

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 PHASE 6: Development Workflow
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Run with verbose output (for debugging)
flutter run -d android --verbose

# Format all code
dart format lib

# Run static analysis
flutter analyze

# Run tests
flutter test

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🎯 EMERGENCY: Force Reset Everything
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

adb kill-server && adb start-server
adb shell am force-stop com.youssef_jaber.casio_fx991
adb shell pm clear com.youssef_jaber.casio_fx991
flutter clean
rm -rf pubspec.lock build/ .dart_tool/
flutter pub get
flutter run -d android

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 💡 KEY SHORTCUTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# While "flutter run" is active in terminal:
# r = Hot reload (fast, keeps app state)
# R = Full restart (reloads everything)
# q = Quit flutter run
# d = Detach debugger
# c = Clear screen
# w = Widget tree
# o = Open DevTools

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 📊 PROJECT STATS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Count lines of Dart code
find lib -name "*.dart" | xargs wc -l | tail -1

# Check file sizes
du -sh build/app/outputs/flutter-apk/*.apk

# List all dependencies
flutter pub deps

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🔐 RELEASE SIGNING (One-Time Setup)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Create keystore
keytool -genkey -v -keystore ~/casio.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias casio -storepass casio123 -keypass casio123

# Create android/key.properties
cat > android/key.properties << 'PROPS'
storeFile=$HOME/casio.jks
storePassword=casio123
keyPassword=casio123
keyAlias=casio
PROPS

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 📱 APK VERIFICATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Check APK exists
ls -lh build/app/outputs/flutter-apk/

# Verify APK signature
jarsigner -verify build/app/outputs/flutter-apk/app-release.apk

# Extract APK contents
cd build/app/outputs/flutter-apk/
unzip -l app-release.apk | grep -E "\.so|\.png|\.dart"

echo "✅ All commands ready to run!"
