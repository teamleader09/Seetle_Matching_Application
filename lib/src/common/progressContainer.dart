import 'package:flutter/material.dart';

class ProgressContainer extends StatelessWidget {
  final int current;
  final int total;
  final Color backgroundColor;
  final Color progressColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;

  const ProgressContainer({
    super.key,
    required this.current,
    required this.total,
    this.backgroundColor = Colors.white,
    this.progressColor = Colors.blue,
    this.textColor = Colors.black,
    this.height = 50,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Progress indicator
          Expanded(
            flex: 1, // 20% of width
            child: Text(
              '$current/$total',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: 5), // Spacing between progress and text

          // Right side - Text (1/5)
          Expanded(
            flex: 4, // 80% of width
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: current / total,
                minHeight: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
