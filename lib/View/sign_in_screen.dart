import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/auth_controller.dart';
import 'package:test_project/Service/auth_service.dart';
import 'package:test_project/widgets/custom_button.dart';

class SignInScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        centerTitle: true,
          title: Text("Sign-In Screen workflow")),
      body: Obx(()=> Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(15),
              Image.asset("assets/login.png",scale: 1.3,),
              Gap(10),
              authController.isLoading.value?Center(child: CircularProgressIndicator(color: Colors.blue.shade200,)):  CustomButton(
                text: "Sign in with google",
                iconData: Icons.login,
                buttonColor: Colors.blue.shade200,
                onPressed: () async {
                await authController.signInWithGoogle();
              },),
            ],
          ),
        ),
      ),
    );
  }
}
