// event_model.dart
// This model represents exhibition event data.
// Each event has information such as title, location, date, status, and image.

class EventModel {
  final String id;
  final String title;
  final String location;
  final String status;
  final String startDate;
  final String endDate;
  final String description;
  final String imagePath;
  final bool isPublished;

  EventModel({
    required this.id,
    required this.title,
    required this.location,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.imagePath,
    required this.isPublished,
  });
}