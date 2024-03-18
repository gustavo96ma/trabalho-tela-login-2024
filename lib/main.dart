import 'package:flutter/material.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  var _modoLogin = true;
  var _emailInserido = '';
  var _senhaInserida = '';
  var _nomeUsuarioInserido = '';

  void _enviar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    _chaveForm.currentState!.save();

    try {
      if (_modoLogin) {
        //logar usuario
        print('Usuário Logado. Email: $_emailInserido, Senha: $_senhaInserida');
      } else {
        //criar usuario
        print(
            'Usuário Criado. Email: $_emailInserido, Senha: $_senhaInserida, Nome de Usuário: $_nomeUsuarioInserido');
      }
    } catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha na autenticação.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: const Icon(Icons.message, size: 200, color: Colors.white),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _chaveForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Endereço de Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty || !value.contains('@')) {
                                  return 'Por favor, insira um endereço de email válido.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailInserido = value!;
                              },
                            ),
                            if (!_modoLogin)
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Nome de Usuário'),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.trim().length < 4) {
                                    return 'Por favor, insira pelo menos 4 caracteres.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _nomeUsuarioInserido = value!;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _senhaInserida = value!;
                              },
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _enviar,
                              child: Text(_modoLogin ? 'Entrar' : 'Cadastrar'),
                            ),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _modoLogin = !_modoLogin;
                                });
                              },
                              child: Text(_modoLogin ? 'Criar uma conta' : 'Já tenho uma conta'),
                            ),
                          ],
                        ),
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
