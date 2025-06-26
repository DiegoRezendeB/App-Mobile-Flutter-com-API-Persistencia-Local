import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  String _user = '', _pass = '';
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Usuário'),
              onSaved: (v) => _user = v!.trim(),
              validator: (v) => v!.isEmpty ? 'Preencha usuário' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              onSaved: (v) => _pass = v!.trim(),
              validator: (v) => v!.isEmpty ? 'Preencha senha' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Entrar'),
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  _form.currentState!.save();
                  final ok = await auth.login(_user, _pass);
                  if (ok) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Credenciais inválidas')),
                    );
                  }
                }
              },
            ),
            TextButton(
              child: const Text('Cadastrar'),
              onPressed: () => Navigator.pushNamed(context, '/register'),
            ),
          ]),
        ),
      ),
    );
  }
}
