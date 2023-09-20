import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final systemBrightnessProvider = Provider.family(
    (ref, BuildContext context) => MediaQuery.of(context).platformBrightness);
