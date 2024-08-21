import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveManagementForm extends StatefulWidget {
  @override
  _LeaveManagementFormState createState() => _LeaveManagementFormState();
}

class _LeaveManagementFormState extends State<LeaveManagementForm> {
  final _formKey = GlobalKey<FormState>();

  // Fields
  String? _selectedState;
  String? _selectedDist;
  String? _selectedTaluka;
  String? _selectedUserProfile;
  DateTime _leaveStartDate = DateTime.now();
  DateTime _leaveEndDate = DateTime.now();
  DateTime _leaveAppliedStartDate = DateTime.now();
  DateTime _leaveAppliedEndDate = DateTime.now();
  String? _leaveApprovedBy;
  String? _leaveRejecter;
  String? _leaveRejecterDescription;
  String? _leaveStatus;

  List<String> _states = ['State1', 'State2', 'State3'];
  List<String> _dists = ['Dist1', 'Dist2', 'Dist3'];
  List<String> _talukas = ['Taluka1', 'Taluka2', 'Taluka3'];
  List<String> _userProfiles = ['User1', 'User2', 'User3'];
  List<String> _leaveStatuses = ['Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    // Set default values
    _selectedState = _states[0];
    _selectedDist = _dists[0];
    _selectedTaluka = _talukas[0];
    _selectedUserProfile = _userProfiles[0];
    _leaveStatus = _leaveStatuses[0];
  }

  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  Widget _buildDateField(String label, DateTime selectedDate, Function(DateTime) onDateChanged) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      controller: TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(selectedDate),
      ),
      onTap: () async {
        await _selectDate(context, selectedDate, onDateChanged);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 75, 146),
        title: Text('Leave Management', style: TextStyle(color: Colors.white, fontSize: 20)),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16),
                // State Selection
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  decoration: InputDecoration(
                    labelText: 'Select State',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
                  items: _states.map((state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // District Selection
                DropdownButtonFormField<String>(
                  value: _selectedDist,
                  decoration: InputDecoration(
                    labelText: 'Select District',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDist = newValue;
                    });
                  },
                  items: _dists.map((dist) {
                    return DropdownMenuItem(
                      value: dist,
                      child: Text(dist),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Taluka Selection
                DropdownButtonFormField<String>(
                  value: _selectedTaluka,
                  decoration: InputDecoration(
                    labelText: 'Select Taluka',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTaluka = newValue;
                    });
                  },
                  items: _talukas.map((taluka) {
                    return DropdownMenuItem(
                      value: taluka,
                      child: Text(taluka),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // User Profile Selection
                DropdownButtonFormField<String>(
                  value: _selectedUserProfile,
                  decoration: InputDecoration(
                    labelText: 'Select User Profile',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserProfile = newValue;
                    });
                  },
                  items: _userProfiles.map((userProfile) {
                    return DropdownMenuItem(
                      value: userProfile,
                      child: Text(userProfile),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Leave Starting Date
                _buildDateField(
                  'Leave Starting Date',
                  _leaveStartDate,
                      (date) {
                    setState(() {
                      _leaveStartDate = date;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Ending Date
                _buildDateField(
                  'Leave Ending Date',
                  _leaveEndDate,
                      (date) {
                    setState(() {
                      _leaveEndDate = date;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Applied Starting Date
                _buildDateField(
                  'Leave Applied Starting Date',
                  _leaveAppliedStartDate,
                      (date) {
                    setState(() {
                      _leaveAppliedStartDate = date;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Applied Ending Date
                _buildDateField(
                  'Leave Applied Ending Date',
                  _leaveAppliedEndDate,
                      (date) {
                    setState(() {
                      _leaveAppliedEndDate = date;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Approved By
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Leave Approved By',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _leaveApprovedBy = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Rejecter
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Leave Rejecter',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _leaveRejecter = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Rejecter Description
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Leave Rejecter Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    setState(() {
                      _leaveRejecterDescription = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Leave Status
                DropdownButtonFormField<String>(
                  value: _leaveStatus,
                  decoration: InputDecoration(
                    labelText: 'Select Leave Status',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _leaveStatus = newValue;
                    });
                  },
                  items: _leaveStatuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data here
                      // For example, print the form values
                      print('State: $_selectedState');
                      print('District: $_selectedDist');
                      print('Taluka: $_selectedTaluka');
                      print('User Profile: $_selectedUserProfile');
                      print('Leave Start Date: ${DateFormat('yyyy-MM-dd').format(_leaveStartDate)}');
                      print('Leave End Date: ${DateFormat('yyyy-MM-dd').format(_leaveEndDate)}');
                      print('Leave Applied Start Date: ${DateFormat('yyyy-MM-dd').format(_leaveAppliedStartDate)}');
                      print('Leave Applied End Date: ${DateFormat('yyyy-MM-dd').format(_leaveAppliedEndDate)}');
                      print('Leave Approved By: $_leaveApprovedBy');
                      print('Leave Rejecter: $_leaveRejecter');
                      print('Leave Rejecter Description: $_leaveRejecterDescription');
                      print('Leave Status: $_leaveStatus');
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Color.fromARGB(255, 19, 75, 146),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
