import 'package:flutter/material.dart';
import 'package:job_search/models/city.dart';
import 'package:job_search/pages/location_locality.dart';

class JobCityPage extends StatefulWidget {
  const JobCityPage({Key? key}) : super(key: key);

  @override
  _JobCityPageState createState() => _JobCityPageState();
}

class _JobCityPageState extends State<JobCityPage> {
  TextEditingController searchController = TextEditingController();
  List<City> filteredCities = citiesList;
  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Job City'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  // Always show the label when the search bar gains or loses focus
                  if (searchController.text.isEmpty) {
                    searchController.clear();
                  }
                });
              },
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                onChanged: (value) {
                  _filterCities(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search cities',
                  labelText: 'Search cities',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(filteredCities[index].name),
                      onTap: () {
                        _navigateToAnotherPage(filteredCities[index]);
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterCities(String query) {
    setState(() {
      filteredCities = citiesList
          .where(
              (city) => city.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _navigateToAnotherPage(City selectedCity) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalityPage(selectedCity: selectedCity.name),
      ),
    ).then((selectedLocality) {
      if (selectedLocality != null) {
        print('$selectedCity, $selectedLocality');
        Navigator.pop(context, {
          "selectedCity": selectedCity.name,
          "selectedLocality": selectedLocality
        });
      }
    });
  }
}
