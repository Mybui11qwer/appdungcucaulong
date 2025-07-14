import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  final String? status;
  const VerifyScreen({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Màu nền sáng
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight/4.2,),
                    Image.asset(
                        "assets/images/${status == 'success' ? 'verify-success.png' : 'verify-failed.png'}", 
                        height: 200,
                      ),
                      // Tiêu đề
                    Text(
                        status == 'success' ? 'Verify Succeess' : 'Verify Failed',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    const SizedBox(height: 12),

                      // Nội dung phụ
                    Text(
                      status == 'success' 
                      ? 'You have succeed verify your email, Now you can login and Enjoy' 
                      : 'Wrong passcode, please enter the\nright passcode',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    const SizedBox(height: 140),
                    ],
                  ),
                // Nút VERIFY AGAIN
                // Chưa xử lý nốt status
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện tại đây
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'VERIFY AGAIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
