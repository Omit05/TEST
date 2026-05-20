// application_model.dart
// This model stores exhibitor booth application information.
// It is created after an exhibitor selects booth and submits the application form.

class ApplicationModel {
  final String id;
  final String eventId;
  final String eventTitle;
  final List<String> boothNumbers;
  final String companyName;
  final String companyDescription;
  final String exhibitProfile;
  final String addOns;

  // Status can be changed by organizer, for example Pending Review, Approved, or Rejected.
  String status;

  // Reason is used when organizer rejects the application.
  String reason;

  ApplicationModel({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.boothNumbers,
    required this.companyName,
    required this.companyDescription,
    required this.exhibitProfile,
    required this.addOns,
    required this.status,
    this.reason = '',
  });
}