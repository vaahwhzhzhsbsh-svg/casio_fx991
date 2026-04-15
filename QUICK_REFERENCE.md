# 🚀 QUICK REFERENCE CARD

## One-Minute Setup

```bash
cd /workspaces/casio_fx991 && bash setup.sh
```

## Three Quick Commands

```bash
bash run.sh debug       # 🔴 Debug (Hot Reload)
bash run.sh release     # 🟢 Release APK
bash run.sh install     # ⬇️ Build & Install
```

---

## Manual Commands Cheat Sheet

```bash
# Development
flutter run -d android
flutter pub get
dart format lib
flutter analyze

# Building
flutter build apk --release
flutter build appbundle --release

# Device Management
adb devices
adb install -r app.apk
adb logcat | grep flutter

# Emergency Reset
flutter clean && rm pubspec.lock
adb kill-server && adb start-server
```

---

## Hot Reload Shortcuts (While Running)

| Key | Action |
|-----|--------|
| `r` | Hot Reload (fast) |
| `R` | Full Restart |
| `q` | Quit |
| `d` | Detach |
| `c` | Clear Screen |

---

## File Navigation

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry |
| `converter_page.dart` | Main UI |
| `conversion_service.dart` | FFmpeg engine |
| `conversion_providers.dart` | State mgmt |
| `animated_header_widget.dart` | Header |
| `AndroidManifest.xml` | Permissions |
| `pubspec.yaml` | Dependencies |

---

## Color Codes

| Color | Hex | Use |
|-------|-----|-----|
| Aqua | `#00d9ff` | Primary |
| Purple | `#b026ff` | Secondary |
| Dark | `#0a0e27` | Background |
| Card | `#1a1f3a` | Surfaces |

---

## Key Configs

**Min Android**: API 26  
**FFmpeg Flags**: `-vcodec h263 -s 176x144 -r 15 -b:v 256k -acodec amr_nb -ar 8000 -ac 1 -ab 12.2k`  
**Max Conversions**: 3 concurrent  
**Queue Limit**: 100 videos  
**Storage**: `/storage/emulated/0/Download/Youssef_Jaber_Converter/`  

---

## Troubleshooting

```bash
# Build errors
flutter clean && rm pubspec.lock && flutter pub get

# FFmpeg issues
flutter pub run build_runner build --delete-conflicting-outputs

# Device connection
adb kill-server && adb start-server

# App crashes
adb shell pm clear com.youssef_jaber.casio_fx991
adb uninstall com.youssef_jaber.casio_fx991
adb install -r app.apk
```

---

## Documentation Map

```
📍 START HERE → DELIVERY_COMPLETE.md
    ↓
📍 QUICK COMMANDS → MAGIC_COMMANDS.sh
    ↓
📍 ALL COMMANDS → TERMINAL_COMMANDS.md
    ↓
📍 ARCHITECTURE → PROJECT_STRUCTURE.md
    ↓
📍 FEATURES → README.md
```

---

## Performance Tips

✅ Select 20-50 videos per batch  
✅ Rename before starting  
✅ Monitor logs in second terminal  
✅ Clear completed to free RAM  
✅ Use Release build for deployment  

---

**Print this. Keep it handy. 🚀**
