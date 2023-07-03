import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo(size: 100),
            _RegisterForm(),
          ],
        ),
      ),
    ));
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            prefixIcon: const Icon(Icons.supervised_user_circle_rounded),
            onChanged: (value) => username = value,
            validator: (p0) {
              if (p0 == null || p0.isEmpty) return 'Campo requerido';
              if (p0.trim().isEmpty) return 'Campo requerido';
              if (p0.length < 6) return 'Se requiren minimo 6 caracteres';

              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electronico',
            prefixIcon: const Icon(Icons.email_rounded),
            onChanged: (value) => email = value,
            validator: (p0) {
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (p0 == null || p0.isEmpty) return 'Campo requerido';
              if (p0.trim().isEmpty) return 'Campo requerido';
              if (!emailRegExp.hasMatch(p0)) return 'Formato de correo requerido';

              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Password',
            subfixIcon: const Icon(Icons.key_rounded),
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (p0) {
              if (p0 == null || p0.isEmpty) return 'Campo requerido';
              if (p0.trim().isEmpty) return 'Campo requerido';
              if (p0.length < 6) return 'Se requiren minimo 6 caracteres';

              return null;
            },
          ),
          const SizedBox(height: 10),
          FilledButton.tonalIcon(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (!isValid) return;
                print('$username, $email, $password');
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
