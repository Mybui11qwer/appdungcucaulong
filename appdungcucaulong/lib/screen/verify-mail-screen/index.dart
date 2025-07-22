import 'package:appdungcucaulong/components/custom-elevated-btn/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/pin-code/index.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';

class VerifyMailScreen extends StatefulWidget {
  const VerifyMailScreen({super.key});

  @override
  State<VerifyMailScreen> createState() => _VerifyMailScreenState();
}

class _VerifyMailScreenState extends State<VerifyMailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 120),
              Image.asset('assets/images/verify-mail.png',height: 180,),
              SizedBox(height: 10),
              CustomTitle(
                text: 'Verify Email',
                txtSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
               child: CustomTitle(text: 'Enter your verification that we sended through your email',textAlign: TextAlign.center,),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: PinCode(txtController: _textEditingController),
              )
            ],
          ),
          Container(
            width: double.infinity,
            margin:  EdgeInsets.only(bottom: 20),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: CustomelElevatebutton(text: 'Verify Now', color: Colors.blue, textColor: Colors.white, onPressed: (){}) ,
          )
        ],
      ),
    );
  }
}
