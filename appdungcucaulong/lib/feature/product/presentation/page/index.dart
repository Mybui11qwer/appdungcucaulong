import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/shared/widget/main_scaffold.dart';
//import '../../../../config/shared/widget/sidebar_widget.dart';
import '../../../../core/network/api_constants.dart';
import '../../../cart/presentation/widget/cart_top_sheet.dart';
import '../../../product/presentation/bloc/product_bloc.dart';
import '../../../product/presentation/bloc/product_state.dart';
import '../../../product/domain/entity/product_entity.dart';
//import '../../../cart/presentation/page/cart_page.dart';
import 'product_detail_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int selectedIndex = 0;

  final List<Map<String, String>> iconData = [
    {
      'title': 'Shuttlecock',
      'desc': 'A shuttlecock, also known as\na birdie, is an essential piece\nof equipment in badminton',
      'bgLeft': 'assets/images/shuttecock/Images7.png',
      'bgRight': 'assets/images/shuttecock/Images5.png',
      'bgBottom': 'assets/images/shuttecock/Images6.png',
    },
    {
      'title': 'Badminton Racket',
      'desc': 'A badminton racket is a\nlightweight, strung implement\nused to hit the shuttlecock in\nbadminton',
      'bgLeft': 'assets/images/racket/racket2.png',
      'bgRight': 'assets/images/racket/racket1.png',
    },
    {
      'title': 'Sneaker',
      'desc': 'Sneaker is a type of athletic\nshoe designed for comfort\nand casual wear.',
      'bgLeft': 'assets/images/sneaker/sneaker2.png',
      'bgRight': 'assets/images/sneaker/sneaker1.png',
    },
    {
      'title': 'Sport Clothes',
      'desc': 'Sportswear refers to clothing\ndesigned for physical activity\nand athletic performance',
      'bgLeft': 'assets/images/cloth/cloth1.png',
      'bgRight': 'assets/images/cloth/cloth2.png',
      'bgBottom': 'assets/images/cloth/cloth3.png',
    },
  ];

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, color: Color(0xFF1A3C6B), size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 0,
      body: Container(
        color: Colors.indigo,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Transform.translate(
                offset: Offset(0, -150), // kéo lên đè lên header
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductLoaded) {
                        final products = state.products.take(4).toList();

                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.70,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 0),
                          children: List.generate(products.length, (index) {
                            final product = products[index];
                            final verticalOffset = index < 2 ? -60.0 : 60.0;

                            return Transform.translate(
                              offset: Offset(0, verticalOffset),
                              child: ProductCard(product: product),
                            );
                          }),
                        );
                      } else if (state is ProductError) {
                        return Center(child: Text('Lỗi: ${state.message}'));
                      } else {
                        return const SizedBox(); // fallback
                      }
                    },
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 300,
                  ),
                  Positioned(
                    top: -14,
                    left: -17,
                    child: Image.asset(
                      'assets/images/Images2.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    top: -27,
                    right: -35,
                    child: Image.asset(
                      'assets/images/Images4.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    right: -35,
                    child: Image.asset(
                      'assets/images/Images1.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: -17,
                    child: Image.asset(
                      'assets/images/Images3.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 20), // Khoảng cách đầu
                          _InfoCard(), // Thẻ 1
                          const SizedBox(width: 16),
                          _InfoCard(), // Thẻ 2
                          const SizedBox(width: 16),
                          _InfoCard(), // Thẻ 3
                          const SizedBox(width: 20), // Khoảng cách cuối
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 330,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/midle_bg.png'),
                      fit: BoxFit.cover,
                    )
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -60,
                      child: Image.asset(
                        iconData[selectedIndex]['bgLeft'] ?? 'assets/images/shuttecock/Images7.png',
                        width: 250,
                        height: 350,
                      ),
                    ),
                    Positioned(
                      top: -40,
                      right: -60,
                      child: Image.asset(
                        iconData[selectedIndex]['bgRight'] ?? 'assets/images/shuttecock/Images5.png',
                        width: 250,
                        height: 350,
                      ),
                    ),
                    if (iconData[selectedIndex]['bgBottom'] != null)
                      Positioned(
                        bottom: 40,
                        right: -5,
                        child: Image.asset(
                          iconData[selectedIndex]['bgBottom']!,
                          width: 100,
                          height: 100,
                        ),
                      ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Text(
                          iconData[selectedIndex]['title']!,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF103F91), // Bỏ hoặc thêm font nếu có
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Text(
                          iconData[selectedIndex]['desc']!,
                          style: TextStyle(
                              fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(-170, 55),
                              child: GestureDetector(
                                onTap: () => setState(() => selectedIndex = 0),
                                child: _buildIcon('assets/images/indexicon/Intersect.png', 0),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(-60, 70),
                              child: GestureDetector(
                                onTap: () => setState(() => selectedIndex = 1),
                                child: _buildIcon('assets/images/indexicon/voticon.png', 1),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(60, 70),
                              child: GestureDetector(
                                onTap: () => setState(() => selectedIndex = 2),
                                child: _buildIcon('assets/images/indexicon/giayicon.png', 2),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(170, 55),
                              child: GestureDetector(
                                onTap: () => setState(() => selectedIndex = 3),
                                child: _buildIcon('assets/images/indexicon/aoicon.png', 3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 320,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/badminton_yard_section.png'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 24),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/badminton_mascot.png',
                  width: 55,
                  height: 55,),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    showCartTopSheet(context);
                  },
                  child: _circleIcon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'The Ultimate\nCollection',
                  style: TextStyle(
                    fontSize: 56,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Best gears ever',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget _buildIcon(String asset, int index) {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(4),
      child: Image.asset(asset),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ProductDetailPage(productId: product.id, product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue.shade50, width: 2),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.indigo,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        '${ApiConstants.baseUrl}/public/images/${product.image}',
                        fit: BoxFit.contain,
                        height: 80,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.price.toStringAsFixed(0)} đ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                const Text(
                  'Racket',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 18), // Để icon không đè lên text
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.blue.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/badminton_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 12,
            right: 12,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),

          Positioned(
            top: 16,
            left: 16,
            child: Row(
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/yonex.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Yonex',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Hcm, VN',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tags dưới cùng
          const Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TagChip(label: 'Racket'),
                _TagChip(label: 'Gear'),
                _TagChip(label: 'Racket'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
