import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'admin_home_page.dart';
import 'exhibitor_home_page.dart';
import 'organizer_home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void loginAs(BuildContext context, String role) {
    context.read<AppProvider>().setRole(role);

    Widget nextPage;

    if (role == 'Exhibitor') {
      nextPage = const ExhibitorHomePage();
    } else if (role == 'Organizer') {
      nextPage = const OrganizerHomePage();
    } else {
      nextPage = const AdminHomePage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => nextPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Login'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.account_circle,
              size: 90,
              color: Colors.indigo,
            ),

            const SizedBox(height: 16),

            const Text(
              'Select Role',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'This is only a UI prototype. No real login or database is connected yet.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => loginAs(context, 'Exhibitor'),
                child: const Text('Login as Exhibitor'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => loginAs(context, 'Organizer'),
                child: const Text('Login as Organizer'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => loginAs(context, 'Administrator'),
                child: const Text('Login as Administrator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}