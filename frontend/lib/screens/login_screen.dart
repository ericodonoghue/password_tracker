import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginMode = true; // Toggles between Login and Register

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(_isLoginMode ? "Welcome to Password Tracker - Login" : "Welcome to Password Tracker - Register")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = _isLoginMode
                    ? await authProvider.login(
                    _usernameController.text, _passwordController.text)
                    : await authProvider.register(
                    _usernameController.text, _passwordController.text);

                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Authentication failed. Please try again.",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },

              child: Text(_isLoginMode ? "Login" : "Register"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginMode = !_isLoginMode; // Switch between login/register
                });
              },
              child: Text(_isLoginMode
                  ? "Don't have an account? Register"
                  : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
