import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'cake_shop_detail_ui.dart';
import 'data/cake_shop_data.dart';
import 'models/cake_shop.dart';


class CakeShopListUI extends StatelessWidget {
  const CakeShopListUI({super.key});


  static const _rowBorder = Color(0xFFFFCDD6);

  void _openDetails(BuildContext context, CakeShop shop) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CakeShopDetailUI(shop: shop),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สายด่วนกินเค้ก',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),
          CarouselSlider.builder(
            itemCount: 7,
            options: CarouselOptions(
              height: 212,
              viewportFraction: 0.80,
              initialPage: 5, 
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: false,
              padEnds: true,
            ),
            itemBuilder: (context, index, realIndex) {
              final poster = 'assets/images/ck${(index + 1).toString().padLeft(2, '0')}.png';
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    poster,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    semanticLabel: 'ตัวอย่างผลงานร้านเค้ก ${index + 1}',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: cakeShops.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 1, color: _rowBorder),
              itemBuilder: (context, index) {
                final shop = cakeShops[index];
                return Container(
                  height: 97,
                  color: const Color(0xFFFFF9FF),
                  child: ListTile(
                    onTap: () => _openDetails(context, shop),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 7,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(
                        shop.image1,
                        width: 87,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      shop.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    subtitle: Text(
                      shop.phone.trim(),
                      style: const TextStyle(fontSize: 14, color: Color(0xFF4C4651)),
                    ),
                    trailing: IconButton(
                      tooltip: 'รายละเอียด ${shop.name}',
                      icon: const Icon(Icons.info, color: Color(0xFFD62731), size: 25),
                      onPressed: () => _openDetails(context, shop),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
