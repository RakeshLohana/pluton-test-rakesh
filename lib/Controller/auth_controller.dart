import 'dart:developer';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/Service/auth_service.dart';
import 'package:test_project/View/home_page.dart';
import 'package:test_project/View/sign_in_screen.dart';

class AuthController extends GetxController {
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = false.obs;
  AuthService authService = AuthService();



  setLoading(bool value) {
    isLoading.value = value;
  }

  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);
      User? user = await authService.signInWithGoogle();
      if (user != null) {
        firebaseUser.value = user;
        Get.snackbar('Success', 'Signed in successfully with Google!',
            snackPosition: SnackPosition.BOTTOM);
        Get.to(HomePage());

      }
    } catch (e) {
      log('Error signing in with Google: $e');
      Get.snackbar('Error', 'Failed to sign in with Google',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setLoading(false);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      setLoading(true);
      await authService.signOut();
      firebaseUser.value = null;
      Get.offAll(SignInScreen());
      Get.snackbar('Success', 'Signed out successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      log('Error signing out: $e');
      Get.snackbar('Error', 'Failed to sign out',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setLoading(false);
    }
  }


  //
  // Future<void> getCurrentUser() async {
  //   try {
  //     setLoading(true);
  //     User? user = await authService.getCurrentUser();
  //     firebaseUser.value = user;
  //   } catch (e) {
  //     log('Error getting current user: $e');
  //   } finally {
  //     setLoading(false);
  //   }
  // }
}
