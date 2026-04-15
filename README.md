# 🎥 Youssef Jaber - Video Converter

**Ultra-Fast MP4 to itel 3GP Converter for Android**

---

## 📋 Features

✨ **Animated Header** - Shimmer effect with "Youssef Jaber" branding  
⚡ **Queue Management** - Handle 100+ videos with concurrent processing (max 3)  
🎨 **Glassmorphism UI** - Dark mode with Aqua & Neon Purple accents  
📱 **Haptic Feedback** - Interactive buttons with tactile response  
🔄 **Batch Conversion** - Multi-thread using Isolates  
💾 **Auto-Storage** - Direct save to `/Download/Youssef_Jaber_Converter/`  
🎬 **FFmpeg Integration** - Professional-grade video encoding

---

## 🛠 Setup

### Prerequisites

```bash
flutter --version  # Must be >= 3.10.0
```

### Install Dependencies

```bash
cd casio_fx991
flutter pub get
```

### Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🚀 Build & Run

### Debug (Development)

```bash
flutter run -d android
```

### Release (Production)

```bash
flutter build apk --release
flutter install --release
```

### AAB (Google Play)

```bash
flutter build appbundle --release
```

---

## 📐 Architecture

```
lib/
├── main.dart                              # App Entry
├── core/
│   ├── constants/app_constants.dart       # Global Constants
│   ├── extensions/extensions.dart         # Utility Extensions
│   └── widgets/                           # Shared Widgets
├── config/
│   └── app_theme.dart                     # Theme Configuration
└── features/
    └── video_conversion/
        ├── data/
        │   ├── datasources/conversion_service.dart  # FFmpeg Service (Isolates)
        │   ├── models/video_model.dart              # Video Data Model
        │   └── repositories/                        # Data Access Layer
        ├── domain/
        │   ├── entities/video_entity.dart           # Business Entity
        │   ├── repositories/                        # Abstract Repositories
        │   └── usecases/                            # Business Logic
        └── presentation/
            ├── pages/converter_page.dart            # Main UI
            ├── providers/conversion_providers.dart  # Riverpod State
            └── widgets/
                ├── animated_header_widget.dart      # Youssef Jaber Header
                └── glass_video_item_widget.dart     # Video Item Card
```

---

## 🎯 Performance Optimization

- **Isolates**: Background thread processing per video
- **Concurrent Limit**: Max 3 simultaneous conversions
- **RAM Efficient**: Streams FFmpeg output
- **Progress Tracking**: Real-time UNIX timestamp updates
- **Queue Management**: Smart scheduling (pending → converting → completed)

---

## 🔧 FFmpeg Flags (itel Optimized)

```
-vcodec h263              # Video codec
-s 176x144                # Resolution
-r 15                     # Frame rate
-b:v 256k                 # Video bitrate
-acodec amr_nb            # Audio codec
-ar 8000                  # Audio sample rate
-ac 1                     # Mono channel
-ab 12.2k                 # Audio bitrate
```

---

## 🔐 Permissions (Android 26+)

```xml
<!-- Manifest permissions enabled -->
- READ_EXTERNAL_STORAGE
- WRITE_EXTERNAL_STORAGE
- MANAGE_EXTERNAL_STORAGE
- MANAGE_MEDIA (API 30+)
```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_riverpod | ^2.4.0 | State Management |
| ffmpeg_kit_flutter_full_gpl | ^6.0.3 | Video Encoding |
| google_fonts | ^6.1.0 | Typography |
| shimmer | ^3.0.0 | Animations |
| flutter_animate | ^4.2.0 | Advanced UI Effects |
| file_picker | ^6.1.1 | File Selection |
| media_store_plus | ^0.0.16 | Storage Access |

---

## 🎨 Color Scheme

| Color | Hex | Purpose |
|-------|-----|---------|
| Dark BG | `#0a0e27` | Background |
| Aqua | `#00d9ff` | Primary |
| Neon Purple | `#b026ff` | Secondary |
| Glass | `#1a1f3a` | Cards/Modals |

---

## 🐛 Troubleshooting

### FFmpeg Build Issues
```bash
flutter clean
rm -rf pubspec.lock
flutter pub get
```

### Permission Denied (Storage)
- Check AndroidManifest.xml permissions
- Request runtime permissions at app startup

### "Queue Limit Exceeded"
- App limits to 100 videos per session
- Clear completed to add more

---

## 💡 Tips

1. **Bulk Convert**: Select 50+ videos at once
2. **Rename Before**: Rename videos in pre-conversion view
3. **Background Processing**: App works with screen off
4. **Auto-Cleanup**: Clear completed items to free memory

---

## 📄 License

© 2026 Youssef Jaber. All rights reserved.

---

**Built with ❤️ using Flutter & FFmpeg**
