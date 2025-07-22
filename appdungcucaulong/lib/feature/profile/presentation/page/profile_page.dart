import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_constants.dart';
import '../../../auth/presentation/page/login_page.dart';
import '../../../order/domain/usecase/get_order_detail_usecase.dart';
import '../../../order/domain/usecase/get_orders_by_customer_usecase.dart';
import '../../../order/presentation/bloc/bloc_event.dart';
import '../../../order/presentation/bloc/checkout_bloc.dart';
import '../../../order/presentation/page/order_history_page.dart';
import '../../domain/di/profile_injection.dart';
import '../../domain/entity/user_entity.dart';
import '../bloc/profile_bloc.dart';
import '../../../product/domain/usecase/get_all_products_usecase.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getOrdersByCustomerUseCase = sl<GetOrdersByCustomerUseCase>();
    final getOrderDetailUseCase = sl<GetOrderDetailUseCase>();
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(LoadUserProfileEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            final UserEntity user = state.user;

            return MainScaffold(
              currentIndex: 4,
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            user.avatar?.isNotEmpty == true
                                ? user.avatar!
                                : '${ApiConstants.baseUrl}/public/images/conbohaha.png',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F2F2),
                      ),
                      child: ListView(
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1.2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: [
                              _buildStatCard(
                                '4',
                                'Orders',
                                Colors.blue,
                                Icons.shopping_cart,
                                onTap: () async {
                                  final customerId = user.id;
                                  final getAllProductsUsecase =
                                      sl<GetAllProductsUsecase>();
                                  try {
                                    final allProducts =
                                        await getAllProductsUsecase();

                                    Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => BlocProvider(
                                              create:
                                                  (_) => OrderHistoryBloc(
                                                    getOrdersByCustomerUseCase,
                                                    getOrderDetailUseCase,
                                                  )..add(
                                                    FetchOrderHistory(
                                                      customerId,
                                                    ),
                                                  ),
                                              child: OrderHistoryPage(
                                                allProducts: allProducts,
                                              ),
                                            ),
                                      ),
                                    );
                                  } catch (e) {
                                    debugPrint(
                                      "Lỗi khi tải danh sách sản phẩm: $e",
                                    );
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Không thể tải danh sách sản phẩm",
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              _buildStatCard('24', 'Runs', Colors.purple, Icons.directions_run),
                              _buildStatCard('10', 'Levels', Colors.lightBlue, Icons.bolt),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            '⚙️ Settings',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF004AAD)),
                          ),
                          const SizedBox(height: 12),
                          _buildSettingItem(Icons.email, 'Email'),
                          _buildSettingItem(Icons.language, 'Languages'),
                          _buildSettingItem(Icons.brightness_6, 'Theme'),
                          _buildSettingItem(Icons.system_update, 'Update'),
                          _buildSettingItem(
                            Icons.logout,
                            'Logout',
                            onTap: () => _logout(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatCard(
    String count,
    String title,
    Color color,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_down),
        onTap: onTap,
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }
}
