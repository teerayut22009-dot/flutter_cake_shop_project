import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CakeCallFastApp());
}

class CakeCallFastApp extends StatelessWidget {
  const CakeCallFastApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light(useMaterial3: true);
    return MaterialApp(
      title: 'สายด่วนกินเค้ก',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: const Color(0xFFFFF9FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF0808),
          surface: const Color(0xFFFFF9FF),
        ),
        textTheme: GoogleFonts.kanitTextTheme(base.textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF0808),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const SplashScreenUI(),
    );
  }
}
