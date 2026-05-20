// status_chip.dart
// This widget displays status labels with different colours.
// Example: Upcoming, Ongoing, Pending Review, Approved, Rejected.

import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({
    super.key,
    required this.status,
  });

  // This function returns colour based on status.
  Color getColor() {
    if (status == 'Upcoming') return Colors.orange;
    if (status == 'Ongoing') return Colors.green;
    if (status == 'Pending Review') return Colors.orange;
    if (status == 'Approved') return Colors.green;
    if (status == 'Rejected') return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: getColor(),
      label: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}