import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/event_card.dart';
import 'event_detail_page.dart';
import 'login_page.dart';

class GuestHomePage extends StatelessWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.watch<AppProvider>().publishedEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibition Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Browse Published Exhibitions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Guest users can view exhibitions and booth layout without login.',
          ),

          const SizedBox(height: 20),

          for (final event in events)
            EventCard(
              event: event,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailPage(eventId: event.id),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}