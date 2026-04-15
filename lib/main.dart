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
