import 'package:flutter/material.dart';
import 'dio_service.dart'; 

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  
  final TextEditingController _emailController = TextEditingController();
  final DioService _dioService = DioService();

  
  final _formKey = GlobalKey<FormState>();

  void _onReset() async {
    final data = {
      'email': _emailController.text,
      'request': 'reset_password'
    };

    
    await _dioService.sendData('reset', data);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Reset sent.')));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const Icon(Icons.lock_reset, size: 100, color: Colors.deepPurple),
                  const SizedBox(height: 32),

                  const Text(
                    "Enter your email to receive instructions",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
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
                  const SizedBox(height: 24),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _onReset();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white, 
                      ),
                      child: const Text("Reset Password", style: TextStyle(fontSize: 18)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back to Login"),
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