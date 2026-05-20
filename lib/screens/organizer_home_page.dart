import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/status_chip.dart';

class OrganizerHomePage extends StatelessWidget {
  const OrganizerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final applications = provider.applications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizer Dashboard'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Application Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Organizer can approve or reject exhibitor booth applications.',
          ),

          const SizedBox(height: 20),

          if (applications.isEmpty)
            const Center(
              child: Text('No application received yet.'),
            ),

          for (final app in applications)
            Card(
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
                    Text('Exhibit Profile: ${app.exhibitProfile}'),
                    Text('Add-ons: ${app.addOns}'),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: app.status == 'Pending Review'
                                ? () {
                              provider.updateApplicationStatus(
                                applicationId: app.id,
                                status: 'Approved',
                              );
                            }
                                : null,
                            child: const Text('Approve'),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: app.status == 'Pending Review'
                                ? () {
                              provider.updateApplicationStatus(
                                applicationId: app.id,
                                status: 'Rejected',
                                reason:
                                'Application rejected by organizer.',
                              );
                            }
                                : null,
                            child: const Text('Reject'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}