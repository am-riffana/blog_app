import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/provider/blog_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startApp();
  }
  Future<void> startApp() async {
    final auth = context.read<AuthProvider>();
    final blogProvider = context.read<BlogProvider>();

    await auth.loadData();
    await blogProvider.load();
    await Future.delayed( Duration(seconds: 2));

    if (!mounted) return;

    if (auth.user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 5, 5),
      body:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.note_add, size: 100, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Blogzi',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            // CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}