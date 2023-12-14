import 'package:flutter/material.dart';
import 'package:job_search/pages/area_of_interest.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController jobCityController = TextEditingController();
  TextEditingController localityController = TextEditingController();

  FocusNode dobFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();

  bool isLocalityVisible = false;

  @override
  void dispose() {
    dobFocusNode.dispose();
    genderFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Let's create your Profile",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Container(
                height: 200,
                width: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/welcome.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInputField(
                      controller: fullNameController,
                      hintText: 'Full Name',
                      icon: Icons.person,
                    ),
                    _buildInputField(
                      controller: dobController,
                      hintText: 'Date of Birth',
                      icon: Icons.calendar_today,
                      onTap: () => _selectDate(context),
                      focusNode: dobFocusNode,
                    ),
                    _buildInputField(
                      controller: genderController,
                      hintText: 'Gender',
                      icon: Icons.person_outline,
                      isDropDown: true,
                      onTap: () => _showGenderDialog(context),
                      focusNode: genderFocusNode,
                    ),
                    _buildInputField(
                      controller: jobCityController,
                      hintText: 'Job City',
                      icon: Icons.location_city,
                      onTap: () {
                        _navigateToJobCityPage();
                      },
                    ),
                    Visibility(
                      visible: isLocalityVisible,
                      child: _buildInputField(
                        controller: localityController,
                        hintText: 'Location',
                        icon: Icons.location_on,
                      ),
                    ),
                    Visibility(
                      visible: isLocalityVisible,
                      child: ButtonTheme(
                        minWidth: 400.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> formData = {
                              'fullName': fullNameController.text,
                              'dob': dobController.text,
                              'gender': genderController.text,
                              'jobCity': jobCityController.text,
                              'jobLocation': localityController.text
                            };

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  AreaOfInterestPage(formData: formData,),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 24.0,
                                  color: Colors.white,
                                  weight: 900,
                                ), // Right-pointing icon
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isDropDown = false,
    VoidCallback? onTap,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        onTap: () {
          if (focusNode != null) {
            FocusScope.of(context).requestFocus(focusNode);
          }
          if (onTap != null) {
            onTap();
          }
        },
        readOnly: hintText == 'Job City',
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: Icon(icon),
          labelText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      dobController.text = pickedDate.toLocal().toString().split(' ')[0];
    }
  }

  Future<void> _showGenderDialog(BuildContext context) async {
    String? selectedGender = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  Navigator.pop(context, 'Male');
                  FocusScope.of(context).unfocus();
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  Navigator.pop(context, 'Female');
                  FocusScope.of(context).unfocus();
                },
              ),
              ListTile(
                title: const Text('Transgender'),
                onTap: () {
                  Navigator.pop(context, 'Female');
                  FocusScope.of(context).unfocus();
                },
              ),
              ListTile(
                title: const Text('Prefer not to say'),
                onTap: () {
                  Navigator.pop(context, 'Female');
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedGender != null) {
      genderController.text = selectedGender;
    }
  }

  void _navigateToJobCityPage() async {
    final selectedData = await Navigator.pushNamed(context, 'city') as Map;

    if (selectedData.isNotEmpty) {
      final selectedCity = selectedData["selectedCity"];
      final selectedLocality = selectedData["selectedLocality"];

      jobCityController.text = selectedCity;
      localityController.text = selectedLocality;

      setState(() {
        isLocalityVisible = true; // Show locality field
      });
    }
  }
}
