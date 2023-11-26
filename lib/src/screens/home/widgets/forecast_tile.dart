import 'package:flutter/material.dart';

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ForecastTileSingle(),
          ForecastTileSingle(),
          ForecastTileSingle(),
          ForecastTileSingle(),
        ],
      ),
    );
  }
}
