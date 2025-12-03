import 'package:flutter/material.dart';
import 'dio_service.dart';
import 'sign_up_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DioService _dioService = DioService();

  
  final _formKey = GlobalKey<FormState>();

  
  void _onLogin() async {
    final data = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'action': 'login_attempt'
    };

    
    await _dioService.sendData('login', data);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request sent.')));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkv267KrzreoWIbziu406g43Ur_BDkD0Dedw&s",
                    width: 150,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.account_circle, size: 150, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 32.0),

                  
                  TextFormField(
                    controller: _emailController, 
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(), 
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  
                  TextFormField(
                    controller: _passwordController, 
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 7) {
                        return 'Password must be at least 7 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),

                  
                  SizedBox(
                    width: double.infinity, 
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        
                        if (_formKey.currentState!.validate()) {
                          
                          _onLogin();
                        }
                      },
                      child: const Text("Sign In", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                      );
                    },
                    child: const Text("Forgot password?"),
                  ),

                  
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}