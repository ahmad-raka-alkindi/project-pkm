import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      color: AppColors.navy,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  );
}
