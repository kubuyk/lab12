import 'package:flutter/material.dart';
import 'dio_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DioService _dioService = DioService();

  
  final _formKey = GlobalKey<FormState>();

  
  void _onSignUp() async {
    final data = {
      'fullName': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'created_at': DateTime.now().toString()
    };

    
    await _dioService.sendData('signup', data);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration data sent.')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  
                  Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkv267KrzreoWIbziu406g43Ur_BDkD0Dedw&s",
                    width: 100,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person_add, size: 100, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 32),

                  
                  TextFormField(
                    controller: _nameController, 
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.badge),
                      border: OutlineInputBorder(), 
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  
                  TextFormField(
                    controller: _emailController, 
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email (Login)',
                      prefixIcon: Icon(Icons.email_outlined),
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
                  const SizedBox(height: 16),

                  
                  TextFormField(
                    controller: _passwordController, 
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
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
                  const SizedBox(height: 24),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        
                        if (_formKey.currentState!.validate()) {
                          
                          _onSignUp();
                        }
                      },
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back to Sign In'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}