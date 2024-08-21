import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // Initialize with default values
  String _selectedState = 'State1';
  String _selectedDist = 'Dist1';
  String _selectedTaluka = 'Taluka1';

  TextEditingController _firstNameController = TextEditingController(text: 'John');
  TextEditingController _middleNameController = TextEditingController(text: 'Middle');
  TextEditingController _lastNameController = TextEditingController(text: 'Doe');
  TextEditingController _contactController = TextEditingController(text: '+911234567890');
  TextEditingController _addressController = TextEditingController(text: '123 Main St');
  TextEditingController _totalYearlyLeavesController = TextEditingController(text: '20');

  DateTime _createdAt = DateTime.now();
  DateTime _updatedAt = DateTime.now();

  List<String> _states = ['State1', 'State2', 'State3'];
  List<String> _dists = ['Dist1', 'Dist2', 'Dist3'];
  List<String> _talukas = ['Taluka1', 'Taluka2', 'Taluka3'];

  Future<void> _selectDateTime(BuildContext context, DateTime initialDate, Function(DateTime) onDateTimeSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (time != null) {
        final DateTime dateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        onDateTimeSelected(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 20)),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 19, 75, 146),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/eoffice.png'), // Replace with actual image
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_firstNameController.text} ${_lastNameController.text}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _contactController.text,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Editable Information
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButtonFormField<String>(
                        value: _selectedState,
                        hint: Text('Select State'),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedState = newValue;
                            });
                          }
                        },
                        items: _states.map((state) {
                          return DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedDist,
                        hint: Text('Select Dist'),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedDist = newValue;
                            });
                          }
                        },
                        items: _dists.map((dist) {
                          return DropdownMenuItem(
                            value: dist,
                            child: Text(dist),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedTaluka,
                        hint: Text('Select Taluka'),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedTaluka = newValue;
                            });
                          }
                        },
                        items: _talukas.map((taluka) {
                          return DropdownMenuItem(
                            value: taluka,
                            child: Text(taluka),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      // SizedBox(height: 16),
                      // TextFormField(
                      //   controller: _middleNameController,
                      //   decoration: InputDecoration(labelText: 'Middle Name'),
                      // ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _contactController,
                        decoration: InputDecoration(
                            labelText: 'Contact',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                            labelText: 'Address',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _totalYearlyLeavesController,
                        decoration: InputDecoration(
                            labelText: 'Total Yearly Leaves',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      // SizedBox(height: 16),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await _selectDateTime(context, _createdAt, (dateTime) {
                      //             setState(() {
                      //               _createdAt = dateTime;
                      //             });
                      //           });
                      //         },
                      //         // child: Text('Created At: ${DateFormat('yyyy-MM-dd HH:mm').format(_createdAt)}'),
                      //         child: Text('Created At'),
                      //       ),
                      //     ),
                      //     SizedBox(width: 16),
                      //     Expanded(
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await _selectDateTime(context, _updatedAt, (dateTime) {
                      //             setState(() {
                      //               _updatedAt = dateTime;
                      //             });
                      //           });
                      //         },
                      //         // child: Text('Updated At: ${DateFormat('yyyy-MM-dd HH:mm').format(_updatedAt)}'),
                      //         child: Text('Updated At'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data here
                    }
                  },
                  child: Text('Save Changes', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Color.fromARGB(255, 19, 75, 146),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
