import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booth_model.dart';
import '../providers/app_provider.dart';
import '../widgets/booth_map.dart';
import 'application_form_page.dart';

class BoothSelectionPage extends StatelessWidget {
  final String eventId;

  const BoothSelectionPage({
    super.key,
    required this.eventId,
  });

  void showBoothDetails(BuildContext context, BoothModel booth) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              Text(
                'Booth ${booth.boothNumber}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ListTile(
                leading: const Icon(Icons.category),
                title: Text('Type: ${booth.type}'),
              ),
              ListTile(
                leading: const Icon(Icons.square_foot),
                title: Text('Size: ${booth.size} sqm'),
              ),
              ListTile(
                leading: const Icon(Icons.payments),
                title: Text('Price: RM ${booth.price.toStringAsFixed(0)}'),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text('Amenities: ${booth.amenities}'),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: booth.status == BoothStatus.booked
                      ? null
                      : () {
                    context
                        .read<AppProvider>()
                        .toggleBoothSelection(booth);

                    Navigator.pop(context);
                  },
                  child: Text(
                    booth.status == BoothStatus.selectedByMe
                        ? 'Remove Selection'
                        : 'Select Booth',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final event = provider.getEventById(eventId);
    final booths = provider.getBoothsByEvent(eventId);
    final selectedBooths = provider.getSelectedBooths(eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booth Selection'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Tap an available booth to view details and select it.',
          ),

          const SizedBox(height: 20),

          BoothMap(
            booths: booths,
            isInteractive: true,
            onBoothTap: (booth) {
              showBoothDetails(context, booth);
            },
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text('Selected Booths: ${selectedBooths.length}'),
              subtitle: Text(
                selectedBooths.isEmpty
                    ? 'No booth selected yet.'
                    : selectedBooths.map((booth) => booth.boothNumber).join(', '),
              ),
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            icon: const Icon(Icons.description),
            label: const Text('Continue to Application Form'),
            onPressed: selectedBooths.isEmpty
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ApplicationFormPage(eventId: eventId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}