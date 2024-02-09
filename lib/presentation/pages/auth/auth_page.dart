import 'package:fareshare/presentation/widgets/auth/login_widget.dart';
import 'package:fareshare/presentation/widgets/auth/register_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: isLogin
            ? LoginWidget(onClickedRegister: toggle)
            : RegisterWidget(onClickedLogin: toggle),
      );
}
