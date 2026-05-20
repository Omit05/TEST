// mock_data.dart
// This file stores temporary sample data for the app.
// Since Firebase/MySQL is not connected yet, the app uses this mock data first.


import '../models/application_model.dart';
import '../models/booth_model.dart';
import '../models/event_model.dart';

class MockData {
  // Sample exhibition event list.
  static List<EventModel> events = [
    // Add event data here.
    EventModel(
      id: 'E001',
      title: 'Malaysia Trade Expo 2026',
      location: 'KL Convention Centre',
      status: 'Upcoming',
      startDate: '20 June 2026',
      endDate: '23 June 2026',
      description:
      'A trade exhibition for business, technology, cooperative products and networking.',
      imagePath: 'assets/images/Question Marl.png',
      isPublished: true,
    ),
    EventModel(
      id: 'E002',
      title: 'Tourism & Lifestyle Exhibition',
      location: 'World Trade Centre Kuala Lumpur',
      status: 'Ongoing',
      startDate: '10 July 2026',
      endDate: '12 July 2026',
      description:
      'An exhibition focusing on tourism, wellness, lifestyle and local business products.',
      imagePath: 'assets/images/SHAHALAM.png',
      isPublished: true,
    ),
  ];

  // Sample booth list.
  // Each booth is connected to an event using eventId.
  static List<BoothModel> booths = [
    // Add booth data here.
    BoothModel(
      id: 'B001',
      eventId: 'E001',
      boothNumber: 'A-01',
      type: 'Standard',
      size: 12,
      price: 800,
      amenities: 'Power socket, table, 2 chairs',
      status: BoothStatus.available,
    ),
    BoothModel(
      id: 'B002',
      eventId: 'E001',
      boothNumber: 'A-02',
      type: 'Premium',
      size: 20,
      price: 1500,
      amenities: 'Power socket, WiFi, premium location',
      status: BoothStatus.available,
    ),
    BoothModel(
      id: 'B003',
      eventId: 'E001',
      boothNumber: 'A-03',
      type: 'Standard',
      size: 12,
      price: 800,
      amenities: 'Power socket, table, 2 chairs',
      status: BoothStatus.booked,
    ),
    BoothModel(
      id: 'B004',
      eventId: 'E001',
      boothNumber: 'B-01',
      type: 'Premium',
      size: 20,
      price: 1500,
      amenities: 'Power socket, WiFi, front row',
      status: BoothStatus.available,
    ),
    BoothModel(
      id: 'B005',
      eventId: 'E002',
      boothNumber: 'C-01',
      type: 'Standard',
      size: 10,
      price: 700,
      amenities: 'Power socket and display table',
      status: BoothStatus.available,
    ),
    BoothModel(
      id: 'B006',
      eventId: 'E002',
      boothNumber: 'C-02',
      type: 'Premium',
      size: 18,
      price: 1300,
      amenities: 'Power socket, WiFi, corner booth',
      status: BoothStatus.available,
    ),
  ];

  // This list stores submitted applications temporarily.
  // The data will reset when the app restarts because there is no database yet.
  static List<ApplicationModel> applications = [];
}