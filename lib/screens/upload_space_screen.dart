import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_cultural_renter/data/facility.dart';
import 'package:home_cultural_renter/data/room.dart';
import 'package:home_cultural_renter/data/utils.dart';
import 'package:image_picker/image_picker.dart';

class UploadSpaceScreen extends StatefulWidget {
  const UploadSpaceScreen({super.key});

  @override
  State<UploadSpaceScreen> createState() => _UploadSpaceScreenState();
}

class _UploadSpaceScreenState extends State<UploadSpaceScreen> {
  List<Facility> _facilities = [];
  var rooms = [
    'https://gos3.ibcdn.com/d007e016c81711e68f680a209fbd0127.jpg',
    'https://media-cdn.tripadvisor.com/media/vr-splice-j/06/5a/dc/fe.jpg',
    'http://4.bp.blogspot.com/-PntU7M4gb2k/TyCOye9kdAI/AAAAAAAAAY4/jKqAE4Ea2cA/s1600/10.JPG',
    'https://www.seawatersports.com/img/newimage/places/konkan-museum-in-maharashtra.jpg'
  ];
  Room room = Room();
  final roomNameETC = TextEditingController();
  final roomSpecialityETC = TextEditingController();
  var fac;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Room to your profile"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Room",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Address"),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Address", label: Text("Room Address")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Room Photos"),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: ListView(
                  padding: const EdgeInsets.all(12),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      4,
                      (index) => InkWell(
                            onTap: () {},
                            child: Image(
                              image: NetworkImage(rooms[index]),
                              height: 100,
                              width: 200,
                              color: Colors.grey[100],
                            ),
                          ))),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(28.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Your Speciality",
                    label: Text("Space Speciality")),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Facilities"),
                IconButton(
                    onPressed: () async {
                      fac = await showDialog(
                          context: context,
                          builder: (context) {
                            var facEditController = TextEditingController();
                            var facdmtEditController = TextEditingController();

                            return AlertDialog(
                              content: Column(
                                children: [
                                  // TextField(
                                  //   controller: facEditController,
                                  // ),
                                  TextField(
                                    decoration: InputDecoration(),
                                    keyboardType: TextInputType.number,
                                    controller: facdmtEditController,
                                  ),
                                  DropdownButton(
                                      value: "Room",
                                      items: const [
                                        DropdownMenuItem<String>(
                                            value: "Room", child: Text("Room")),
                                        DropdownMenuItem<String>(
                                            value: "Food", child: Text("Food")),
                                        DropdownMenuItem<String>(
                                            value: "Event",
                                            child: Text("Event")),
                                      ],
                                      onChanged: (mi) {})
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(Facility(
                                          facEditController.text,
                                          double.parse(
                                              facdmtEditController.text)));
                                    },
                                    child: const Icon(Icons.done))
                              ],
                            );
                          });
                      setState(() {
                        _facilities.add(fac);
                      });
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: ListView.builder(
                itemCount: _facilities.length,
                itemBuilder: (context, idx) => ListTile(
                  title: Text(_facilities[idx].facility),
                  subtitle: Text(_facilities[idx].amount.toString()),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    var ims = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    //alert to upload bill
                    uploadImage(File(ims!.path));
                  },
                  child: const Text("Upload Light Bill")),
            ),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.location_city_sharp),
                onPressed: () {
                  // TODO:PICK LOCATION
                },
                label: const Text("Pick Lankmark Location"),
              ),
            ),
            /* ElevatedButton.icon(
              icon: const Icon(Icons.date_range),
              onPressed: () async {
                var dateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 120000)));

              },
              label: const Text("Select Date Range"),
            ),*/
            Center(child: Text("Price")),
            Builder(builder: (context) {
              return Center(child: Container(child: TextField()));
            }),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    var usr = FirebaseAuth.instance.currentUser;

                    var r = Room();
                    r.name = roomNameETC.text;
                    r.description = roomSpecialityETC.text;
                    r.facilities = fac;

                    if (usr != null) {
                      await FirebaseFirestore.instance
                          .collection("spaces")
                          .doc(usr.uid)
                          .collection("rooms")
                          .add(r.toMap());
                      print("Added Room");
                    }
                  },
                  child: const Text("Confirm")),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: 3,
          items: [
            BottomNavigationBarItem(
              label: 'Dashboard',
              icon: const Icon(Icons.dashboard),
            ),
            BottomNavigationBarItem(
              label: 'Requests',
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
