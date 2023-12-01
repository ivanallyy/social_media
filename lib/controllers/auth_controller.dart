import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/sign_in_screen.dart';
import '../widgets/bottom_navbar.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() {
          return const SignInScreen();
        });
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void clearValues() {
    username.clear();
    email.clear();
    password.clear();
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if (firebaseAuth.currentUser != null) {
        clearValues();
        Get.offAll(() {
          return const BottomNavbar();
        });
      }
    } catch (error) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(16),
        title: 'Error',
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFFFF6161),
        ),
        middleText: 'Something went wrong.',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Color(0xFF7737FF),
              ),
            ),
          ),
        ],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      if (firebaseAuth.currentUser != null) {
        clearValues();
        Get.offAll(() {
          return const BottomNavbar();
        });
      }
    } catch (error) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(16),
        title: 'Error',
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFFFF6161),
        ),
        middleText: 'Something went wrong.',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Color(0xFF7737FF),
              ),
            ),
          ),
        ],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueWithGoogle() async {
    try {} catch (error) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(16),
        title: 'Error',
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFFFF6161),
        ),
        middleText: 'Something went wrong.',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Color(0xFF7737FF),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<void> signOut() async {
    try {
      firebaseAuth.signOut();
    } catch (error) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(16),
        title: 'Error',
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFFFF6161),
        ),
        middleText: 'Something went wrong.',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Color(0xFF7737FF),
              ),
            ),
          ),
        ],
      );
    }
  }
}
