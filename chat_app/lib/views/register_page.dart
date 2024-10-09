import 'package:chat_app/components/auth_button.dart';
import 'package:chat_app/components/confirm_button.dart';
import 'package:chat_app/components/custom_input.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/show_message.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

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
              Icons.app_registration,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 40),
            const Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: nameController,
              labelText: 'Nome',
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: phoneController,
              labelText: 'Telefone',
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: passwordController,
              labelText: 'Senha',
              isObscure: true,
            ),
            const SizedBox(height: 16),
            CustomInput(
              controller: confirmController,
              labelText: 'Repita sua Senha',
              isObscure: true,
            ),
            const SizedBox(height: 24),
            ConfirmButton(
              labelText: 'Cadastrar',
              onPressed: () async {
                try {
                  await FirebaseAuthService().register(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                    passwordController.text,
                  );

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                } catch (e) {
                  showMessage(context, e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
