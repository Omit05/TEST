import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrator Dashboard'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'System Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Events',
                  value: provider.publishedEvents.length.toString(),
                  icon: Icons.event,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Applications',
                  value: provider.applications.length.toString(),
                  icon: Icons.assignment,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Admin Features',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const _FeatureTile(
            icon: Icons.map,
            title: 'Floor Plan Management',
            subtitle: 'Upload and manage floor plan images. UI only for now.',
          ),
          const _FeatureTile(
            icon: Icons.event_available,
            title: 'Exhibition Management',
            subtitle: 'Manage exhibitions and published status. UI only for now.',
          ),
          const _FeatureTile(
            icon: Icons.store,
            title: 'Booth Management',
            subtitle: 'Create booth types, set prices and availability.',
          ),
          const _FeatureTile(
            icon: Icons.people,
            title: 'User Account Management',
            subtitle: 'Manage exhibitor, organizer and admin accounts.',
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, color: Colors.indigo, size: 34),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}