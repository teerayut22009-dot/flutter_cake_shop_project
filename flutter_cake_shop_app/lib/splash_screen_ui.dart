import 'dart:async';
import 'package:flutter/material.dart';
import 'cake_shop_list_ui.dart';


class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const CakeShopListUI(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg_welcome.png', fit: BoxFit.cover),
          Positioned(
            top: displayHeight * 0.147,
            left: 12,
            right: 12,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'สายด่วนกินเค้ก',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFF0808),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'CAKE CALL FAST',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF5059),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 42,
                    height: 42,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Color(0xFF36454F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
