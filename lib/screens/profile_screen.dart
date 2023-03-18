import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final nameEdTxtCont = TextEditingController();
  final phoneEdTxtCont = TextEditingController();
  final addEdTxtCont = TextEditingController();
  final emEdTxtCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(),
            Text("Name"),
            TextField(
              readOnly: true,
              controller: nameEdTxtCont,
            ),
            Text("Phone"),
            TextField(
              readOnly: true,
              controller: phoneEdTxtCont,
            ),
            Text("Address"),
            TextField(
              readOnly: true,
              controller: addEdTxtCont,
            ),
            Text("email"),
            TextField(
              readOnly: true,
              controller: emEdTxtCont,
            ),

            // if(!aadharVerification)
            ElevatedButton(
                onPressed: () {}, child: Text("Upload And Verify Aadhar"))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: 2,
          items: [
            BottomNavigationBarItem(
              label: 'Dashboard',
              icon: const Icon(Icons.dashboard),
            ),
            BottomNavigationBarItem(
              label: 'Request',
              icon: const Icon(Icons.request_page),
            ),
            BottomNavigationBarItem(
                label: 'Profile', icon: const Icon(Icons.person_2_rounded)),
            BottomNavigationBarItem(
                label: 'Create Space',
                icon: const Icon(Icons.location_city_rounded)),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.of(context).pushNamed("/dashboard");
                break;
              case 1:
                Navigator.of(context).pushNamed("/requests");
                break;
              case 2:
                Navigator.of(context).pushNamed("/profile");
                break;
              default:
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
