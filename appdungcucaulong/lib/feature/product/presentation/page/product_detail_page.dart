// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_constants.dart';
//import '../../../cart/data/dto/request/add_to_cart_dto.dart';
//import '../../../cart/presentation/bloc/cart_bloc.dart';
//import '../../../cart/presentation/bloc/cart_event.dart';
//import '../../../cart/presentation/widget/cart_top_sheet.dart';
import '../../../cart/data/dto/request/add_to_cart_dto.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/widget/cart_top_sheet.dart';
import '../../domain/entity/product_entity.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.productId,
  });
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final GlobalKey _content4Key = GlobalKey();

  void _scrollToContent4() {
    final ctx = _content4Key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 245),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  //Content 1
                  SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Warm and Clean',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 1, 94, 255),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Our product ensures you experience the perfect balance of warmth and comfort, keeping you cozy while maintaining freshness, no matter the environment.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Content 2
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Easy Washing',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 1, 94, 255),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Our product ensures you experience the perfect balance of warmth and comfort, keeping you cozy while maintaining freshness, no matter the environment.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Content 3
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Guard Safe',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 1, 94, 255),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Our product ensures you experience the perfect balance of warmth and comfort, keeping you cozy while maintaining freshness, no matter the environment.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Content 4
                  const SizedBox(height: 50),
                  Padding(
                    key: _content4Key,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E58D6), Color(0xFF3A7BD5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children:  [
                              Icon(Icons.credit_card, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                '${widget.product.price} vnđ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Material: Plastic, WOOL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Variant: Black, White, Orage',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Description: Black, White, Orage',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Content 5
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/badminton_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Icon yêu thích ở góc trên phải
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),

                          // Logo và thông tin bên trái
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
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                _TagChip(label: 'Racket'),
                                _TagChip(label: 'Gear'),
                                _TagChip(label: 'Racket'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: 300,
              color: Color(0xFF3A7BD5),
              alignment: Alignment.center,
              child: Image.network(
                '${ApiConstants.baseUrl}/public/images/lening.png',
                height: 200,
              ),
            ),
          ),
          // Icon tròn giữa cố định
          Positioned(
            top: 240,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Icon(Icons.layers, size: 32, color: Color(0xFF103F91)),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Icon(Icons.arrow_back, size: 24, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
        ],
      ),
      //SideBar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0x3F0872FD),
                blurRadius: 4,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionBox(
                color: Color(0xFF103F91),
                icon: Icons.info,
                onTap: _scrollToContent4,
              ),
              _ActionBox(
                color: Color(0xFF788AFF),
                icon: Icons.favorite,
                onTap: null,
              ),
              _ActionBox(
                color: Color(0xFF82A8FB),
                icon: Icons.share,
                onTap: null,
              ),
              _ActionBox(
                color: Color(0xFF999191),
                icon: Icons.shopping_bag,
                onTap: () {
                  showCartTopSheet(context);
                },
              ),
              _ActionBox(
                color: Color(0xFF4D4350),
                icon: Icons.shopping_cart,
                onTap: () {
                  final dto = AddToCartDTO(
                    productId: widget.product.id,
                    sizeId: 1,
                    quantity: 1,
                  );

                  context.read<CartBloc>().add(AddToCartEvent(dto));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đã thêm vào giỏ hàng")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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

class _ActionBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionBox({
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3F000000),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: Colors.white)),
      ),
    );
  }
}
