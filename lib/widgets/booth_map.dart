// booth_map.dart
// This widget displays booth layout using GridView.
// It works like a simple visual floor plan/map.
// Green means available, red means booked, and blue means selected.

import 'package:flutter/material.dart';

import '../models/booth_model.dart';

class BoothMap extends StatelessWidget {
  final List<BoothModel> booths;

  // If true, user can tap the booth.
  // If false, booth map is read-only for guest users.
  final bool isInteractive;

  final Function(BoothModel booth)? onBoothTap;

  const BoothMap({
    super.key,
    required this.booths,
    required this.isInteractive,
    this.onBoothTap,
  });

  // Decide booth colour based on booth status.
  Color getBoothColor(BoothStatus status) {
    if (status == BoothStatus.available) return Colors.green;
    if (status == BoothStatus.booked) return Colors.red;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend explains colour meaning.
        const Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _Legend(color: Colors.green, label: 'Available'),
            _Legend(color: Colors.red, label: 'Booked'),
            _Legend(color: Colors.blue, label: 'Selected'),
          ],
        ),

        const SizedBox(height: 16),

        // GridView is used to display booths in map layout.
        GridView.builder(
          shrinkWrap: true,

          // Disable scrolling inside GridView because the main screen already scrolls.
          physics: const NeverScrollableScrollPhysics(),

          itemCount: booths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            final booth = booths[index];

            return InkWell(
              // Booth can only be tapped if isInteractive is true.
              onTap: isInteractive
                  ? () {
                if (onBoothTap != null) {
                  onBoothTap!(booth);
                }
              }
                  : null,

              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getBoothColor(booth.status),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      booth.boothNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      booth.type,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'RM ${booth.price.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Small widget for booth colour legend.
class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 7, backgroundColor: color),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}