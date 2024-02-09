import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const RegisterWidget({super.key, required this.onClickedLogin});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Регистрација',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(74, 44, 60, 1.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(74, 44, 60, 1.0),
                    width: 3.0,
                  ),
                ),
                labelStyle: TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                isDense: true,
                label: Text('Е-пошта'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(74, 44, 60, 1.0),
                    width: 3.0,
                  ),
                ),
                labelStyle: TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                isDense: true,
                label: Text('Лозинка'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(74, 44, 60, 1.0),
                  foregroundColor: Colors.white
              ),
              child: const Text('Регистрирај се'),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Имаш профил? ',
                style:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedLogin,
                    text: 'Најави се',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(74, 44, 60, 1.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
