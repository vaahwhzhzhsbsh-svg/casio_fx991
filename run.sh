#!/bin/bash

# Fast Build & Run Script
# Usage: ./run.sh [debug|release|clean]

MODE="${1:-debug}"
TARGET="${2:-android}"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}▶ Youssef Jaber Converter - Build & Run${NC}"
echo ""

case $MODE in
  "debug")
    echo -e "${BLUE}Building DEBUG mode...${NC}"
    flutter run -d $TARGET --verbose
    ;;
  
  "release")
    echo -e "${BLUE}Building RELEASE APK...${NC}"
    flutter build apk --release --verbose
    echo -e "${GREEN}✓ APK ready at: build/app/outputs/flutter-apk/app-release.apk${NC}"
    ;;
  
  "aab")
    echo -e "${BLUE}Building App Bundle (AAB)...${NC}"
    flutter build appbundle --release --verbose
    echo -e "${GREEN}✓ AAB ready at: build/app/outputs/bundle/release/app-release.aab${NC}"
    ;;
  
  "clean")
    echo -e "${BLUE}Cleaning build artifacts...${NC}"
    flutter clean
    rm -rf pubspec.lock build/ .dart_tool/
    echo -e "${GREEN}✓ Cleaned${NC}"
    ;;
  
  "install")
    echo -e "${BLUE}Building and installing APK...${NC}"
    flutter build apk --release
    adb install -r build/app/outputs/flutter-apk/app-release.apk
    echo -e "${GREEN}✓ Installed on device${NC}"
    ;;
  
  *)
    echo -e "${RED}Unknown mode: $MODE${NC}"
    echo "Usage: $0 [debug|release|aab|clean|install]"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}Done!${NC}"
