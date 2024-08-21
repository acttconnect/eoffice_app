import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveDashboard extends StatelessWidget {
  final List<Map<String, String>> leaveRequests = [
    {
      'name': 'John Doe',
      'leaveType': 'Sick Leave',
      'startDate': '2024-08-20',
      'endDate': '2024-08-22',
      'status': 'Pending',
    },
    {
      'name': 'Jane Smith',
      'leaveType': 'Annual Leave',
      'startDate': '2024-08-15',
      'endDate': '2024-08-18',
      'status': 'Approved',
    },
    {
      'name': 'Alice Johnson',
      'leaveType': 'Casual Leave',
      'startDate': '2024-08-25',
      'endDate': '2024-08-26',
      'status': 'Pending',
    },
    {
      'name': 'Bob Brown',
      'leaveType': 'Sick Leave',
      'startDate': '2024-08-10',
      'endDate': '2024-08-12',
      'status': 'Approved',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            // Header with Logo and Notification Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
                Icon(CupertinoIcons.bell, size: 24)
              ],
            ),
            // GridView with fixed height
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              childAspectRatio: 2, // Adjust aspect ratio for card size
              children: [
                Card(
                  color: Colors.blue[100],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total Leave Requests', style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
                        Text(leaveRequests.length.toString(), style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.yellow[100],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pending Requests', style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
                        Text(
                          leaveRequests.where((request) => request['status'] == 'Pending').length.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.green[100],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Approved Requests', style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
                        Text(
                          leaveRequests.where((request) => request['status'] == 'Approved').length.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.red[100],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Rejected Requests', style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
                        Text(
                          leaveRequests.where((request) => request['status'] == 'Rejected').length.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Leave Requests List and Button
            ListView.builder(
              itemCount: leaveRequests.length,
              shrinkWrap: true, // Shrinks to fit the content
              physics: NeverScrollableScrollPhysics(), // Prevents scrolling
              itemBuilder: (context, index) {
                final request = leaveRequests[index];
                return Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      '${request['name']} - ${request['leaveType']}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      'From: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(request['startDate']!))}\n'
                          'To: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(request['endDate']!))}',
                    ),
                    trailing: Text(
                      request['status']!,
                      style: TextStyle(
                        color: request['status'] == 'Approved' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 19, 75, 146)),
                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 40)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddLeaveRequestPage()),
                );
              },
              child: Text('Add Leave Request', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16), // Add space below the button if needed
          ],
        ),
      ),
    );
  }
}

class AddLeaveRequestPage extends StatefulWidget {
  @override
  _AddLeaveRequestPageState createState() => _AddLeaveRequestPageState();
}

class _AddLeaveRequestPageState extends State<AddLeaveRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String? _leaveType;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  List<String> _leaveTypes = ['Sick Leave', 'Annual Leave', 'Casual Leave'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 75, 146),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Add Leave Request', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _leaveType,
              decoration: InputDecoration(
                labelText: 'Select Leave Type',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _leaveType = newValue;
                });
              },
              items: _leaveTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 19, 75, 146)),
                  ),
                  onPressed: () async {
                    await _selectDate(context, _startDate, (date) {
                      setState(() {
                        _startDate = date;
                      });
                    });
                  },
                  child: Text('Select Date', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 19, 75, 146)),
                  ),
                  onPressed: () async {
                    await _selectDate(context, _endDate, (date) {
                      setState(() {
                        _endDate = date;
                      });
                    });
                  },
                  child: Text('Select Date', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 19, 75, 146)),
                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 40)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Leave Type: $_leaveType');
                  print('Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}');
                  print('End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}');
                }
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
