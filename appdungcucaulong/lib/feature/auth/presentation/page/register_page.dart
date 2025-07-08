import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dto/request/register_request_dto.dart';
import '../../domain/di/auth_injection.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF003C8F),
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ ${state.message}")),
              );
            } else if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("✅ Đăng ký thành công")));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginPage()),
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
                  controller: usernameController,
                  hintText: "Username",
                  icon: Icons.person_outline,
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                buildTextField(
                  controller: emailController,
                  hintText: "E-mail",
                  icon: Icons.email_outlined,
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                buildTextField(
                  controller: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone_outlined,
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
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed:
                          state is RegisterLoading
                              ? null
                              : () {
                                final dto = RegisterRequestDto(
                                  username: usernameController.text.trim(),
                                  email: emailController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                                context.read<RegisterBloc>().add(
                                  SubmitRegister(dto),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state is RegisterLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xFF003C8F),
                            )
                          : const Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Color(0xFF003C8F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Login",
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
}
