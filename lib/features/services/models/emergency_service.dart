import 'package:flutter/material.dart';

class EmergencyNumber {
  final String name;
  final String number;
  final IconData icon;
  final Color color;
  final List<Color> gradient;

  EmergencyNumber({
    required this.name,
    required this.number,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}