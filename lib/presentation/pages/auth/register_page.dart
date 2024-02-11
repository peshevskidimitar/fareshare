import 'package:fareshare/presentation/widgets/auth/register_form.dart';
import 'package:fareshare/repository/auth/auth_repository.dart';
import 'package:fareshare/service/cubits/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрација')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(context.read<AuthenticationRepository>()),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
