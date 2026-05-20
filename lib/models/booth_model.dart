// booth_model.dart
// This model represents booth information.
// It stores booth number, type, size, price, amenities, and current booth status.

// Enum is used to limit booth status to only three possible values.
enum BoothStatus {
  available,      // Booth is available and can be selected.
  booked,         // Booth is already booked and cannot be selected.
  selectedByMe,   // Booth is selected by the current exhibitor.
}

class BoothModel {
  final String id;
  final String eventId;
  final String boothNumber;
  final String type;
  final double size;
  final double price;
  final String amenities;

  // Status can change when user selects or books a booth.
  BoothStatus status;

  BoothModel({
    required this.id,
    required this.eventId,
    required this.boothNumber,
    required this.type,
    required this.size,
    required this.price,
    required this.amenities,
    required this.status,
  });
}