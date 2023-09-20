import 'package:flutter/material.dart';

extension ColorToString on Color {
  string() => '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
