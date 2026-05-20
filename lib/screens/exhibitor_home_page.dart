import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'booth_selection_page.dart';
import 'my_applications_page.dart';

class ExhibitorHomePage extends StatelessWidget {
  const ExhibitorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.watch<AppProvider>().publishedEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibitor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyApplicationsPage(),
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
            'Choose Exhibition',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          for (final event in events)
            Card(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: Text(event.title),
                subtitle: Text('${event.location}\n${event.startDate}'),
                isThreeLine: true,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BoothSelectionPage(eventId: event.id),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}