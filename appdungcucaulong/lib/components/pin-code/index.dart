import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatefulWidget {
  final TextEditingController txtController;
  const PinCode({super.key,required this.txtController});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PinCodeTextField(
        appContext: context,
        length: 4, // Độ dài của pin code
        animationType:  AnimationType.fade,// hiệu ứng
        keyboardType: TextInputType.number,// kiểu dữ liệu được nhập vào
        //Thiết lập giao diện nhập mã pin
        pinTheme: PinTheme(
          borderRadius: BorderRadius.circular(10),
          borderWidth: 0.7,
          inactiveColor: Colors.grey,
          inactiveFillColor: Colors.white,
          shape: PinCodeFieldShape.circle,
          selectedColor: Colors.blueAccent,
          selectedFillColor: Colors.white,
          activeFillColor: Colors.blue,
          activeColor: Colors.white,
          fieldHeight: 58,
          fieldWidth: 58,
        ),
        cursorColor: Colors.blueAccent,
        animationDuration: const Duration(microseconds: 200),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white
        ),
        enableActiveFill: true,
        controller: widget.txtController,
      ),
    );
  }
}