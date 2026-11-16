import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/cake_shop.dart';

class CakeShopDetailUI extends StatelessWidget {
  const CakeShopDetailUI({super.key, required this.shop});

  final CakeShop shop;

  static const _appBarColor = Color(0xFFFA4039);
  static const _pageColor = Color(0xFFFFF9FF);

  Future<void> _openLink(BuildContext context, String value) async {
    try {
      final url = Uri.parse(value);
      final opened = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) {
        _showError(context, 'ไม่สามารถเปิดลิงก์บนอุปกรณ์นี้ได้');
      }
    } catch (_) {
      if (context.mounted) {
        _showError(context, 'ไม่สามารถเปิดลิงก์บนอุปกรณ์นี้ได้');
      }
    }
  }

  Future<void> _callShop(BuildContext context) async {
    final cleanPhone = shop.phone.replaceAll(RegExp(r'\s+'), '');
    await _openLink(context, 'tel:$cleanPhone');
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageColor,
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text(
          shop.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          tooltip: 'กลับหน้ารวมร้าน',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 21),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(29, 25, 29, 26),
          children: [
            Column(
              children: [
                _cakeImage(shop.image1, width: 120, height: 80),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _cakeImage(shop.image2, width: 120, height: 80),
                    const SizedBox(width: 20),
                    _cakeImage(shop.image3, width: 120, height: 80),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            _label('ชื่อร้าน 🏬'),
            Text(shop.name, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 15),
            _label('เวลาเปิดปิด ⏰'),
            Text(shop.openCloseTime, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 19),
            _label('รายละเอียดของร้าน 🍵'),
            Text(
              shop.description,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 14, height: 1.24),
            ),
            const SizedBox(height: 22),
            _label('ที่อยู่ของร้าน 🚩'),
            Text(shop.address, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 22),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _callShop(context),
                icon: const FaIcon(FontAwesomeIcons.phone, size: 15),
                label: Text(
                  shop.phone.trim(),
                  style: const TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EB557),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.padded,
                  padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 6),
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _socialLink(
              context,
              icon: const FaIcon(FontAwesomeIcons.globe, size: 21,
                color: Color(0xFFF2BA15)),
              url: shop.website,
            ),
            const SizedBox(height: 7),
            _socialLink(
              context,
              icon: const FaIcon(FontAwesomeIcons.facebook, size: 21,
                color: Color(0xFF3678EE)),
              url: shop.facebook,
            ),
            const SizedBox(height: 11),
            ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: SizedBox(
                height: 368,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: shop.coordinates,
                    initialZoom: 14.5,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.flutter_cake_shop_project',
                      maxZoom: 19,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: shop.coordinates,
                          width: 50,
                          height: 50,
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            Icons.location_on,
                            color: Color(0xFFE33A34),
                            size: 42,
                          ),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: ColoredBox(
                        color: Color(0xDEFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            '© OpenStreetMap contributors',
                            style: TextStyle(fontSize: 10, color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cakeImage(String path, {required double width, required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _label(String value) {
    return Text(
      value,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _socialLink(
    BuildContext context, {
    required Widget icon,
    required String url,
  }) {
    return InkWell(
      onTap: () => _openLink(context, url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                url,
                style: const TextStyle(fontSize: 14, color: Color(0xFF29232C)),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.link, size: 20, color: Color(0xFF34303D)),
          ],
        ),
      ),
    );
  }
}
