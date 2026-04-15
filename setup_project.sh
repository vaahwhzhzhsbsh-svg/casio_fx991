#!/bin/bash
set -e

# Create Flutter project
flutter create --org com.youssef_jaber --project-name casio_fx991 . || true

# Update pubspec.yaml with all dependencies
cat > pubspec.yaml << 'PUBSPEC_EOF'
name: casio_fx991
description: "Youssef Jaber Video Converter - Ultra-Fast MP4 to 3GP"
publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  ffmpeg_kit_flutter_full_gpl: ^6.0.3
  file_picker: ^6.1.1
  media_store_plus: ^0.0.16
  google_fonts: ^6.1.0
  shimmer: ^3.0.0
  flutter_animate: ^4.2.0
  image: ^4.1.1
  path_provider: ^2.1.1
  permission_handler: ^11.5.1
  video_thumbnail: ^0.5.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.6
  riverpod_generator: ^2.3.9

flutter:
  uses-material-design: true
  assets:
    - assets/

  fonts:
    - family: GoogleFonts
      fonts:
        - asset: fonts/ElMessiri-Regular.ttf
PUBSPEC_EOF

# Create folder structure - Clean Architecture
mkdir -p lib/{core,features,config}
mkdir -p lib/core/{constants,utils,extensions,widgets}
mkdir -p lib/features/{video_conversion,home}
mkdir -p lib/features/video_conversion/{data,domain,presentation}
mkdir -p lib/features/video_conversion/data/{datasources,repositories,models}
mkdir -p lib/features/video_conversion/domain/{entities,repositories,usecases}
mkdir -p lib/features/video_conversion/presentation/{pages,providers,widgets}
mkdir -p lib/features/home/{presentation/{pages,widgets},providers}
mkdir -p assets

# Create main.dart
cat > lib/main.dart << 'MAIN_DART_EOF'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/video_conversion/presentation/pages/converter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youssef Jaber Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0a0e27),
        primaryColor: const Color(0xFF00d9ff),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0a0e27),
          elevation: 0,
          titleTextStyle: GoogleFonts.elMessiri(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00d9ff),
          ),
        ),
        textTheme: GoogleFonts.elMessiriTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const ConverterPage(),
    );
  }
}
MAIN_DART_EOF

echo "✅ Project structure created successfully!"
echo "📦 Installing dependencies..."
flutter pub get

