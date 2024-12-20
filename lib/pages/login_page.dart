// login_page.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart'; // Import HomePage
import 'new_user_page.dart'; // Import NewUserPage

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  Future<void> _login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(_usernameController.text);
    if (savedPassword != null && savedPassword == _passwordController.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: _usernameController.text)),
      );
    } else {
      // Handle invalid credentials
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('asset/order.json', width: 200, height: 200),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _loginForm(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewUserPage()));
                },
                child: Text('Create New User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => _login(context),
          child: Text('Login'),
        ),
      ],
    );
  }
}
