import 'package:flutter/material.dart';
import 'package:mainalihr/model/industry_model.dart';
import 'package:mainalihr/utility/ApiUtil.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key}); // Added a constructor with a key
  @override
  _ClientFormState createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _clientName = '';
  String _companyName = '';
  String _clientNo = '';
  String _clientEmail = '';
  String _allLocations = '';

  List<Industry> industries = []; // Industries will be loaded dynamically
  List<int> selectedIndustryIds = []; // Store selected industry IDs
  bool isLoading = true; // Track loading state for industries

  @override
  void initState() {
    super.initState();
    loadIndustries(); // Load industries when the form initializes
  }

  // Function to load industries dynamically
  Future<void> loadIndustries() async {
    try {
      ApiUtil apiUtil = ApiUtil(); // Create an instance of the class
      List<Industry> fetchedIndustries = await apiUtil.fetchIndustries();

      setState(() {
        industries = fetchedIndustries;
        isLoading = false; // Data has been loaded, stop showing loader
      });
    } catch (e) {
      print('Failed to load industries: $e');
      setState(() {
        isLoading = false; // Even if it fails, stop the loader
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        backgroundColor: Colors.teal, // Custom color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Client Name
              _buildTextField(
                label: 'Client Name',
                onSave: (value) => _clientName = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the Your name'
                    : null,
              ),

              const SizedBox(height: 16),

              // Company Name
              _buildTextField(
                label: 'Company Name',
                onSave: (value) => _companyName = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the company name'
                    : null,
              ),

              const SizedBox(height: 16),

              // Client Number
              _buildTextField(
                label: 'Contact Numbrt',
                onSave: (value) => _clientNo = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Your Contact No'
                    : null,
              ),

              const SizedBox(height: 16),

              // Client Email
              _buildTextField(
                label: 'Client Email',
                onSave: (value) => _clientEmail = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the Your email'
                    : null,
              ),

              const SizedBox(height: 16),

              // Locations
              _buildTextField(
                label: 'All Locations',
                onSave: (value) => _allLocations = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the location'
                    : null,
              ),

              const SizedBox(height: 20),

              // Industries with Checkboxes
              const Text(
                'Select Industries:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator()) // Show loader while industries are being fetched
                  : Column(
                      children: industries.map((industry) {
                        return CheckboxListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          activeColor: Colors.teal,
                          title: Text(industry.industryName),
                          value: selectedIndustryIds.contains(industry.id),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedIndustryIds.add(industry.id);
                              } else {
                                selectedIndustryIds.remove(industry.id);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form save or submission (if needed)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form is valid!'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields with rounded borders
  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Rounded border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.teal, // Border color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.teal, // Focused border color
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: Colors.teal.withOpacity(0.05), // Light background color
      ),
      onSaved: onSave,
      validator: validator,
    );
  }
}
