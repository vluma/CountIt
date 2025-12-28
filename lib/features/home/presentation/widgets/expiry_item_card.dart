import 'package:flutter/material.dart';

class ExpiryItemCard extends StatelessWidget {
  final String name;
  final int? daysLeft;
  final int? hoursLeft;

  const ExpiryItemCard({
    super.key,
    required this.name,
    this.daysLeft,
    this.hoursLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              daysLeft != null
                  ? '剩 $daysLeft 天'
                  : '剩 $hoursLeft 小时',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
