import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  String _user = '', _pass = '';
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
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
              child: const Text('Cadastrar'),
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  _form.currentState!.save();
                  await auth.register(_user, _pass);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cadastro realizado!')),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
