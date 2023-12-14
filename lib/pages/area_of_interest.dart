// Existing Dart file

import 'package:flutter/material.dart';
import 'package:job_search/models/interest.dart';


class AreaOfInterestPage extends StatefulWidget {
  Map<String, dynamic> formData;

  AreaOfInterestPage({super.key, required this.formData});

  @override
  State<AreaOfInterestPage> createState() => _AreaOfInterestPageState();
}

class _AreaOfInterestPageState extends State<AreaOfInterestPage> {
  List<String> selectedInterests = [];
  TextEditingController searchController = TextEditingController();

  List<Interest> allInterests = interests;
  List<Interest> filteredInterests = interests;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              if (selectedInterests.isEmpty)
                Container(
                  height: 150,
                  width: 300,
                  child: const Text(
                    'Lets Start by Selecting Your Area of Interest',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (selectedInterests.isNotEmpty)
                Container(
                  height: 150,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: selectedInterests.length,
                    itemBuilder: (context, index) {
                      String selectedInterest = selectedInterests[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedInterests.remove(selectedInterest);
                          });
                        },
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/$selectedInterest.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black, width: 2, )
                                  ),
                            ),
                            const Positioned(
                                top: 15.0,
                                right: 3.0,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: const Color.fromARGB(255, 24, 0, 143),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Choose Your Category",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      'You have to choose Atleast One Category',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          _filterInterests(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search interests',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: filteredInterests.length,
                      itemBuilder: (context, index) {
                        Interest interest = filteredInterests[index];
                        bool isSelected = selectedInterests.contains(interest.name);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedInterests.remove(interest.name);
                              } else {
                                selectedInterests.add(interest.name);
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      // Circular image with shadow
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/${interest.name}.png'),
                                                ),
                                                borderRadius: BorderRadius.circular(50),
                                                boxShadow:const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(255, 141, 141, 141),
                                                    blurRadius: 15
                                                  )
                                                ] ,
                                                ),
                                          ),
                                          Text(
                                            interest.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: isSelected
                                  ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 26,
                                  )
                                  : const Icon(
                                    Icons.check_circle_outline,
                                    color: Color.fromARGB(255, 220, 220, 220),
                                    size: 26,
                                  ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: selectedInterests.isNotEmpty,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Handle the submit action
          },
          label: const Text('Submit'),
          icon: const Icon(Icons.check),
          backgroundColor: Colors.blue,        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _filterInterests(String query) {
    setState(() {
      filteredInterests = allInterests
          .where((interest) =>
              interest.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
