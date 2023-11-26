import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/models/auto_complete_model.dart';
import 'package:weather_app/src/providers/save_location_provider.dart';

class SearchTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final List<Prediction> searchResults;
  final Function()? onTap;
  final bool isLoading;

  const SearchTextField(
      {super.key,
      this.onChanged,
      required this.searchResults,
      this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveLocationProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.45),
              borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[300]),
                  border: InputBorder.none,
                  hintText: 'Search City',
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  suffixIcon: isLoading
                      ? Transform.scale(
                          scale: 0.5, child: const CircularProgressIndicator())
                      : null),
            ),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: searchResults.length,
          itemBuilder: (context, index) => Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              onTap: () {
                provider.selectedLocationTemp =
                    searchResults[index].placeId ?? "";
                provider.getLocationWeather();
              },
              minLeadingWidth: 10,
              leading: const Icon(Icons.location_on),
              title: Text(
                searchResults[index].description ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
      ],
    );
  }
}
