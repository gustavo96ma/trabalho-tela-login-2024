import 'package:flutter/material.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  var _isLoginMode = true;
  var _ra = '';
  var _password = '';

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_isLoginMode) {
      // Implementar lógica de autenticação com RA e senha
      print('Autenticando com RA: $_ra, Senha: $_password');
    } else {
      // Implementar lógica para recuperação de senha
      print('Solicitado recuperação de senha para RA: $_ra');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green, // Alterando a cor de fundo para verde
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  child: const Icon(Icons.lock, size: 200, color: Colors.white),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'RA (Registro Acadêmico)'),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor, insira seu RA.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _ra = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Senha'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor, insira sua senha.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: Text(_isLoginMode ? 'Entrar' : 'Recuperar Senha'),
                          ),
                          if (_isLoginMode)
                            TextButton(
                              onPressed: () {
                                // Implementar a lógica para recuperação de senha
                                print('Solicitado recuperação de senha para RA: $_ra');
                              },
                              child: Text('Esqueceu sua senha?'),
                            ),
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoginMode = !_isLoginMode;
                              });
                            },
                            child: Text(_isLoginMode ? 'Esqueceu sua senha?' : 'Voltar ao Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
