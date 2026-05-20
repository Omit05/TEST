import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/status_chip.dart';

class MyApplicationsPage extends StatelessWidget {
  const MyApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final applications = provider.applications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
      ),

      body: applications.isEmpty
          ? const Center(
        child: Text('No application submitted yet.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip(status: app.status),

                  const SizedBox(height: 8),

                  Text(
                    app.eventTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text('Company: ${app.companyName}'),
                  Text('Booths: ${app.boothNumbers.join(', ')}'),
                  Text('Add-ons: ${app.addOns}'),

                  if (app.reason.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Reason: ${app.reason}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Application'),
                    onPressed: app.status == 'Pending Review'
                        ? () {
                      provider.cancelApplication(app.id);
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}