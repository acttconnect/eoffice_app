import 'package:eoffice_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';

class UserAppLoginScreen extends StatefulWidget {
  @override
  _UserAppLoginScreenState createState() => _UserAppLoginScreenState();
}

class _UserAppLoginScreenState extends State<UserAppLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown and text field controllers
  String? _selectedState;
  String? _selectedDist;
  String? _selectedTaluka;
  String? _selectedProfileName;

  final _mobileController = TextEditingController();

  List<String> _states = ['State1', 'State2', 'State3'];
  List<String> _dists = ['Dist1', 'Dist2', 'Dist3'];
  List<String> _talukas = ['Taluka1', 'Taluka2', 'Taluka3'];
  List<String> _profileNames = ['Profile1', 'Profile2', 'Profile3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'eoffice login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Dropdown for State
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  hint: Text('Select State'),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 16.0),
                // Dropdown for District
                DropdownButtonFormField<String>(
                  value: _selectedDist,
                  hint: Text('Select District'),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 16.0),
                // Dropdown for Taluka
                DropdownButtonFormField<String>(
                  value: _selectedTaluka,
                  hint: Text('Select Taluka'),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 16.0),
                // Dropdown for Profile Name
                DropdownButtonFormField<String>(
                  value: _selectedProfileName,
                  hint: Text('Select Profile Name'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedProfileName = newValue;
                    });
                  },
                  items: _profileNames.map((profile) {
                    return DropdownMenuItem(
                      value: profile,
                      child: Text(profile),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 16.0),
                // Mobile Number for OTP
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 16.0),
                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 19, 75, 146),
                    minimumSize: Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    }
                  },
                  child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
