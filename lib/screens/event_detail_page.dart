import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/booth_map.dart';
import '../widgets/status_chip.dart';
import 'login_page.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId;

  const EventDetailPage({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final event = provider.getEventById(eventId);
    final booths = provider.getBoothsByEvent(eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(
            event.imagePath,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 180,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, size: 60),
              );
            },
          ),

          const SizedBox(height: 16),

          StatusChip(status: event.status),

          const SizedBox(height: 8),

          Text(
            event.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),
          Text(event.location),
          Text('${event.startDate} - ${event.endDate}'),

          const SizedBox(height: 16),
          Text(event.description),

          const SizedBox(height: 24),

          const Text(
            'Read-only Booth Layout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          BoothMap(
            booths: booths,
            isInteractive: false,
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Login to Make Booking'),
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
    );
  }
}