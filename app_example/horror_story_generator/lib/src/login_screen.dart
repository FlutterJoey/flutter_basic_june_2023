import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/setup_screen.dart';
import './api.dart' as api;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class LoginFormData {
  String? password;
  String? email;

  void clear() {
    password = null;
    email = null;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final LoginFormData _formData = LoginFormData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/iconica-logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Welcome to the Horror Story Generator!\n'
                              'Log in using your Iconica account to proceed.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                              onSaved: _saveEmail,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text('Password'),
                              ),
                              onSaved: _savePassword,
                              validator: _validatePassword,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FilledButton(
                                onPressed: _submitForm,
                                child: const Text('Login'),
                              ),
                            ),
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
    );
  }

  void _savePassword(value) {
    _formData.password = value;
  }

  void _saveEmail(value) {
    _formData.email = value;
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  void _submitForm() async {
    _formData.clear();
    var form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      if (await login(_formData.email!, _formData.password!)) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SetupScreen()),
          );
        }
      }
      form.reset();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await api.login(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
