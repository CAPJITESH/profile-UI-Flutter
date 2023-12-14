// locality_page.dart

import 'package:flutter/material.dart';
import 'package:job_search/models/locality.dart';

class LocalityPage extends StatefulWidget {
  final String selectedCity;

  LocalityPage({Key? key, required this.selectedCity}) : super(key: key);

  @override
  _LocalityPageState createState() => _LocalityPageState();
}

class _LocalityPageState extends State<LocalityPage> {
  TextEditingController localitySearchController = TextEditingController();
  List<CityLocality> filteredLocalities = [];

  @override
  void initState() {
    super.initState();
    // Generate dummy localities for the selected city
    filteredLocalities = generateLocalitiesForCity(widget.selectedCity, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Selected City: ${widget.selectedCity}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  // Always show the label when the search bar gains or loses focus
                  if (localitySearchController.text.isEmpty) {
                    localitySearchController.clear();
                  }
                });
              },
              child: TextField(
                controller: localitySearchController,
                onChanged: (value) {
                  _filterLocalities(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search localities',
                  labelText: 'Search localities',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocalities.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(filteredLocalities[index].name),
                      onTap: () {
                        // Handle the selection of a locality as needed
                        _handleLocalitySelection(filteredLocalities[index]);
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterLocalities(String query) {
    setState(() {
      filteredLocalities = generateLocalitiesForCity(widget.selectedCity, 10)
          .where((locality) =>
              locality.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleLocalitySelection(CityLocality selectedLocality) {
  print('Selected Locality: ${selectedLocality.name}');

    Navigator.pop(context, selectedLocality.name);
  }
}
