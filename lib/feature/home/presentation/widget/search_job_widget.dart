import 'package:flutter/material.dart';
import 'package:mainalihr/model/Location_currency_model.dart';
import 'package:mainalihr/model/industry_model.dart';
import 'package:mainalihr/utility/ApiUtil.dart';

class SearchWidget extends StatefulWidget {
  final Function(String?, String?) onSearch;

  const SearchWidget({
    super.key,
    required this.onSearch,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late String _selectedIndustry='';
  List<Industry> industries = [];

  late String _selectedLocation = '';
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadIndustries();
    loadLocations();
  }

  Future<void> loadIndustries() async {
    try {
      ApiUtil apiUtil = ApiUtil();
      List<Industry> fetchedIndustries = await apiUtil.fetchIndustries();
      setState(() {
        industries = fetchedIndustries;
        _selectedIndustry = industries.isNotEmpty ? industries[0].id.toString() : '';
      });
    } catch (e) {
      // Implement proper error handling (e.g., show error message to the user)
      print('Failed to load industries: $e');
    }
  }

  Future<void> loadLocations() async {
    try {
      ApiUtil apiUtil = ApiUtil();
      List<Location> fetchedLocations = await apiUtil.fetchLocations();
      setState(() {
        locations = fetchedLocations;
        _selectedLocation = locations.isNotEmpty ? locations[0].id.toString() : '';
      });
    } catch (e) {
      // Implement proper error handling (e.g., show error message to the user)
      print('Failed to load locations: $e');
    }
  }
  

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text('Location:', style: TextStyle(fontSize: 16)),
      DropdownButton<String>(
        hint: const Text('Select location'),
        value: _selectedLocation.isNotEmpty ? _selectedLocation : null,
        onChanged: (String? newValue) {
          setState(() {
            _selectedLocation = newValue!;
          });
        },
        items: locations.map((location) {
          return DropdownMenuItem<String>(
            value: location.id.toString(),
            child: Text(location.location_name),
          );
        }).toList(),
      ),
      const SizedBox(height: 20), // Add some spacing between dropdowns
      const Text('Industry:', style: TextStyle(fontSize: 16)),
      DropdownButton<String>(
        hint: const Text('Select Industry'),
        value: _selectedIndustry.isNotEmpty ? _selectedIndustry : null,
        onChanged: (String? newValue) {
          setState(() {
            _selectedIndustry = newValue!;
          });
        },
        items: industries.map((industry) {
          return DropdownMenuItem<String>(
            value: industry.id.toString(),
            child: Text(industry.industryName),
          );
        }).toList(),
      ),
      const SizedBox(height: 20), // Add some spacing between dropdowns and button
      ElevatedButton(
        onPressed: () {
          print("\n\n");
          print('Search button clicked');
          print('Selected industry: $_selectedIndustry');
          print('Selected location: $_selectedLocation');
          print("\n\n");
          // Call the onSearch function with selected industry and location
          widget.onSearch(_selectedIndustry, _selectedLocation);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text('Search'),
      ),
    ],
  );
}
}