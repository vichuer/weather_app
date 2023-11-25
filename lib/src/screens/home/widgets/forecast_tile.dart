import 'package:flutter/material.dart';

import '../../../env/theme.dart';
import 'forecast_tile_single.dart';

class ForecastTile extends StatelessWidget {
  const ForecastTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ForecastTileSingle(),
          ForecastTileSingle(),
          ForecastTileSingle(),
          ForecastTileSingle(),
        ],
      ),
    );
  }
}
