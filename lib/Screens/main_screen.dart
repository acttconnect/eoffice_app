import 'package:eoffice_app/Screens/leaves.dart';
import 'package:eoffice_app/Screens/document_screen.dart';
import 'package:eoffice_app/Screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getChildren()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.doc, size: 20),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/dismiss.png',width: 20,height: 20,),
            label: 'Leaves',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.profile_circled, size: 20),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.primaries[4],
        unselectedItemColor: Colors.black,
      ),
    );
  }
  List<Widget> _getChildren() {
    return [
      LeaveDashboard(),
      DocumentUploadScreen(),
      LeaveManagementForm(),
      UserProfileForm(),
    ];
  }
}
