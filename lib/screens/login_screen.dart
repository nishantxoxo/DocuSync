import 'package:docu_sync/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: kWhiteColor
          ),
          onPressed: () {},
          label: Text("Sign in with Google", style:  TextStyle( color: kBlackColor),),
          icon: Image.asset('assets/images/g-logo-2.png', height: 20,),
        ),
      ),
    );
  }
}
