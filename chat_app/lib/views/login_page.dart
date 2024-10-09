import 'package:chat_app/components/auth_button.dart';
import 'package:chat_app/components/confirm_button.dart';
import 'package:chat_app/components/custom_input.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/views/feed_page.dart';
import 'package:chat_app/views/home_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.message_outlined,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 40),
            CustomInput(
              controller: emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: passwordController,
              labelText: 'Password',
              isObscure: true,
            ),
            const SizedBox(height: 24),
            ConfirmButton(
              labelText: 'Entrar',
              onPressed: () async {
                try {
                  var user = await FirebaseAuthService()
                      .login(emailController.text, passwordController.text);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => FeedPage(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  const Text('Ainda não tem uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Inscreva-se',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
