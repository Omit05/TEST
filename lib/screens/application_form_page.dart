import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'my_applications_page.dart';

class ApplicationFormPage extends StatefulWidget {
  final String eventId;

  const ApplicationFormPage({
    super.key,
    required this.eventId,
  });

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final exhibitProfileController = TextEditingController();
  final addOnsController = TextEditingController();

  @override
  void dispose() {
    companyNameController.dispose();
    companyDescriptionController.dispose();
    exhibitProfileController.dispose();
    addOnsController.dispose();
    super.dispose();
  }

  void submitApplication() {
    if (!formKey.currentState!.validate()) return;

    context.read<AppProvider>().submitApplication(
      eventId: widget.eventId,
      companyName: companyNameController.text,
      companyDescription: companyDescriptionController.text,
      exhibitProfile: exhibitProfileController.text,
      addOns: addOnsController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully.'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MyApplicationsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final event = provider.getEventById(widget.eventId);
    final selectedBooths = provider.getSelectedBooths(widget.eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Form'),
      ),

      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Selected Booths: ${selectedBooths.map((booth) => booth.boothNumber).join(', ')}',
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter company name';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: companyDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Company Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter company description';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: exhibitProfileController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Exhibit Profile',
                hintText: 'What product/service will you showcase?',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter exhibit profile';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: addOnsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Add-ons',
                hintText: 'Example: WiFi, furniture, promotional spot',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Submit Application'),
              onPressed: submitApplication,
            ),
          ],
        ),
      ),
    );
  }
}