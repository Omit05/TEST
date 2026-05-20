// app_provider.dart
// This provider manages the main app data and logic.
// It handles event list, booth selection, application submission,
// application cancellation, and organizer approval/rejection.

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/application_model.dart';
import '../models/booth_model.dart';
import '../models/event_model.dart';

class AppProvider extends ChangeNotifier {
  // Stores the current role selected by the user.
  // Example: Guest, Exhibitor, Organizer, Administrator.
  String currentRole = 'Guest';

  // Get only published events so guest and exhibitors can view them.
  List<EventModel> get publishedEvents {
    return MockData.events.where((event) => event.isPublished).toList();
  }

  // Get all submitted applications.
  List<ApplicationModel> get applications {
    return MockData.applications;
  }

  // Set the role after the user selects login role.
  void setRole(String role) {
    currentRole = role;
    notifyListeners(); // Refresh UI after role changes.
  }

  // Find one event based on event ID.
  EventModel getEventById(String eventId) {
    return MockData.events.firstWhere((event) => event.id == eventId);
  }

  // Get all booths that belong to a selected event.
  List<BoothModel> getBoothsByEvent(String eventId) {
    return MockData.booths.where((booth) => booth.eventId == eventId).toList();
  }

  // Get booths selected by the exhibitor for one event.
  List<BoothModel> getSelectedBooths(String eventId) {
    return MockData.booths.where((booth) {
      return booth.eventId == eventId &&
          booth.status == BoothStatus.selectedByMe;
    }).toList();
  }

  // This function allows exhibitor to select or remove booth selection.
  void toggleBoothSelection(BoothModel booth) {
    // If booth is already booked, user cannot select it.
    if (booth.status == BoothStatus.booked) {
      return;
    }

    // If booth is available, change it to selected.
    if (booth.status == BoothStatus.available) {
      booth.status = BoothStatus.selectedByMe;
    }
    // If booth is already selected, change it back to available.
    else {
      booth.status = BoothStatus.available;
    }

    notifyListeners(); // Refresh booth map colour.
  }

  // This function creates a new application after exhibitor submits the form.
  void submitApplication({
    required String eventId,
    required String companyName,
    required String companyDescription,
    required String exhibitProfile,
    required String addOns,
  }) {
    final event = getEventById(eventId);
    final selectedBooths = getSelectedBooths(eventId);

    // Create new application object.
    final application = ApplicationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      eventId: eventId,
      eventTitle: event.title,
      boothNumbers: selectedBooths.map((booth) => booth.boothNumber).toList(),
      companyName: companyName,
      companyDescription: companyDescription,
      exhibitProfile: exhibitProfile,
      addOns: addOns,
      status: 'Pending Review',
    );

    // Add the application into temporary mock data list.
    MockData.applications.add(application);

    // After application is submitted, selected booths become booked.
    for (final booth in selectedBooths) {
      booth.status = BoothStatus.booked;
    }

    notifyListeners(); // Refresh UI.
  }

  // This function allows organizer to approve or reject application.
  void updateApplicationStatus({
    required String applicationId,
    required String status,
    String reason = '',
  }) {
    final application = MockData.applications.firstWhere(
          (item) => item.id == applicationId,
    );

    application.status = status;
    application.reason = reason;

    notifyListeners(); // Refresh application status.
  }

  // This function allows exhibitor to cancel application.
  void cancelApplication(String applicationId) {
    MockData.applications.removeWhere((item) => item.id == applicationId);
    notifyListeners(); // Refresh application list.
  }
}