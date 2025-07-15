import 'package:appdungcucaulong/feature/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../product/domain/di/product_injection.dart';
import '../../../product/presentation/bloc/product_event.dart';
import '../../../product/presentation/page/index.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../../domain/di/auth_injection.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF003C8F),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('❌ ${state.message}')));
            } else if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Đăng nhập thành công')),
              );
              //final customerId = state.user.customerId;

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider<ProductBloc>(
                        create: (_) => getIt<ProductBloc>()..add(LoadProductsEvent()),
                        child: IndexPage(),
                      ),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'assets/images/badminton_mascot.png',
                  height: 150,
                ),
                const SizedBox(height: 30),
                buildTextField(
                  controller: emailController,
                  hintText: "E-mail",
                  icon: Icons.email_outlined,
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                buildTextField(
                  controller: passwordController,
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              context.read<LoginBloc>().add(
                                    LoginSubmitted(email, password),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state is LoginLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xFF003C8F),
                            )
                          : const Text(
                              "SIGN IN",
                              style: TextStyle(
                                color: Color(0xFF003C8F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialButton(FontAwesomeIcons.apple, () {}),
                    socialButton(FontAwesomeIcons.google, () {}),
                    socialButton(FontAwesomeIcons.facebookF, () {}),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => RegisterPage()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  static Widget socialButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white,
        child: Icon(icon, color: Color(0xFF003C8F)),
      ),
    );
  }
}
