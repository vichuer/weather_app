import 'package:flutter/material.dart';

import '../../../env/theme.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.grad1,
          AppColors.grad2,
          AppColors.grad3,
          AppColors.grad4,
          AppColors.grad1,
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
    );
  }
}
