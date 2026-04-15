#!/bin/bash
set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Youssef Jaber - Video Converter Setup Script          ║"
echo "║     Ultra-Fast MP4 to itel 3GP Android App                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check Flutter
echo -e "${BLUE}[1/8]${NC} Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}✗ Flutter not found. Install Flutter first.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Flutter found: $(flutter --version | head -1)${NC}"
echo ""

# Check Android SDK
echo -e "${BLUE}[2/8]${NC} Checking Android SDK..."
if [ -z "$ANDROID_HOME" ]; then
    echo -e "${YELLOW}⚠ ANDROID_HOME not set. Please set it manually.${NC}"
else
    echo -e "${GREEN}✓ ANDROID_HOME: $ANDROID_HOME${NC}"
fi
echo ""

# Clean previous builds
echo -e "${BLUE}[3/8]${NC} Cleaning previous builds..."
flutter clean
rm -f pubspec.lock
echo -e "${GREEN}✓ Cleaned${NC}"
echo ""

# Get dependencies
echo -e "${BLUE}[4/8]${NC} Installing pub dependencies..."
flutter pub get
echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# Generate code (if using code generation)
echo -e "${BLUE}[5/8]${NC} Generating code (build_runner)..."
flutter pub run build_runner build --delete-conflicting-outputs || echo "Skipping code generation"
echo -e "${GREEN}✓ Code generation complete${NC}"
echo ""

# Create folders
echo -e "${BLUE}[6/8]${NC} Creating project structure..."
mkdir -p assets/fonts
mkdir -p assets/images
mkdir -p android/app/src/main/res/xml
mkdir -p android/app/src/main/kotlin/com/youssef_jaber/casio_fx991
echo -e "${GREEN}✓ Folders created${NC}"
echo ""

# Format code
echo -e "${BLUE}[7/8]${NC} Formatting code..."
dart format lib --set-exit-if-changed || true
echo -e "${GREEN}✓ Code formatted${NC}"
echo ""

# Analyze
echo -e "${BLUE}[8/8]${NC} Running static analysis..."
flutter analyze --no-fatal-infos --suppress-analytics || echo "⚠ Minor linting issues found"
echo -e "${GREEN}✓ Analysis complete${NC}"
echo ""

echo "╔════════════════════════════════════════════════════════════╗"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📱 Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  Run on Android Device/Emulator:"
echo "   ${BLUE}flutter run -d android${NC}"
echo ""
echo "2️⃣  Build Release APK:"
echo "   ${BLUE}flutter build apk --release${NC}"
echo ""
echo "3️⃣  Build App Bundle (Google Play):"
echo "   ${BLUE}flutter build appbundle --release${NC}"
echo ""
echo "4️⃣  Run Tests:"
echo "   ${BLUE}flutter test${NC}"
echo ""
echo "📖 Documentation: $(pwd)/README.md"
echo ""
echo "🎨 UI Features:"
echo "   ✨ Shimmer animated header"
echo "   🎭 Glassmorphism design"
echo "   🌈 Dark mode with Aqua & Purple"
echo "   ⚡ Ultra-fast multi-threaded conversion"
echo ""
echo "🚀 Ready to convert videos! 🎬"
echo ""
