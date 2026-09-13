import 'package:auto_swift/core/components/custom_botton.dart';
import 'package:auto_swift/core/components/custom_text.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:auto_swift/core/components/snack.dart';
import 'package:auto_swift/core/routing/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLogin = true;

  Future<void> _authenticate() async {
    print('AUTH BUTTON PRESSED');

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      print('Email: $email');
      print('Password entered: ${password.isNotEmpty}');

      if (isLogin) {
        print('LOGIN MODE');

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        print('LOGIN SUCCESS');

        if (!mounted) return;

        Snack().success(
          context,
          'User Logged in Successfully',
        );
      } else {
        print('REGISTER MODE');

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print('REGISTER SUCCESS');

        if (!mounted) return;

        Snack().success(
          context,
          'User Created Successfully',
        );
      }

      if (!mounted) return;

      context.push(AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      print('FIREBASE ERROR');
      print('CODE: ${e.code}');
      print('MESSAGE: ${e.message}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Authentication failed',
          ),
        ),
      );
    } catch (e) {
      print('GENERAL ERROR: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),

            const Icon(
              CupertinoIcons.lock,
              size: 100,
            ),

            const SizedBox(height: 30),

            CustomTextField(
              controller: _emailController,
              hint: 'Email',
              type: TextInputType.emailAddress,
            ),

            const SizedBox(height: 10),

            CustomTextField(
              controller: _passwordController,
              hint: 'Password',
              type: TextInputType.text,
            ),

            const SizedBox(height: 20),

            CustomButton(
              onTap: _authenticate,
              width: double.infinity,
              height: 35,
              color: Colors.black87,
              radius: 8,
              child: Center(
                child: CustomText(
                  text: isLogin ? 'Login' : 'Register',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: CustomText(
                text: isLogin
                    ? 'Create an account'
                    : 'Already have an account? Login',
                color: Colors.black,
              ),
            ),

            const Spacer(),

            const CustomText(
              text: 'powered by A wasfy 2026',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}