// App Colors
const Color kColorDarkBg = Color(0xFF0a0e27);
const Color kColorAqua = Color(0xFF00d9ff);
const Color kColorNeonPurple = Color(0xFFb026ff);
const Color kColorGlassLight = Color(0xFF1a1f3a);

// Storage
const String kOutputDir = '/storage/emulated/0/Download/Youssef_Jaber_Converter';

// FFmpeg Flags for itel 3GP
const String kItelFlags = 
  '-vcodec h263 -s 176x144 -r 15 -b:v 256k '
  '-acodec amr_nb -ar 8000 -ac 1 -ab 12.2k';

// Performance
const int kMaxConcurrentConversions = 3;
const int kQueueLimit = 100;

import 'package:flutter/material.dart';
