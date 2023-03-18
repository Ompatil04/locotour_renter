import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:home_cultural_renter/screens/dashboard.dart';
import 'package:home_cultural_renter/widgets/room_tile.dart';

import '../data/facility.dart';
import '../data/room.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<Room> upcomingRoom = [
    Room.arg(
        "id",
        "Umesh Wagh",
        "landmarkPlaceId",
        "1/04/2023 - 20/04/2023",
        "description",
        "lightBillId",
        [Facility("Room", 2500), Facility("food", 1000)]),
    Room.arg(
        "id",
        "Lalit Puri",
        "landmarkPlaceId",
        "12/04/2023 - 24/04/2023",
        "description",
        "lightBillId",
        [Facility("Room", 3500), Facility("food", 2000)])
  ];
  @override
  void initState() {
    //TODO:

    // if (FirebaseAuth.instance.currentUser != null) {
    //   FirebaseFirestore.instance
    //       .collection("spaces")
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection("rooms")
    //       .get()
    //       .then((snap) {
    //     _bookedRooms.clear();
    //     snap.docs.forEach((doc) {
    //       var r = Room.fromMap(doc.data());
    //       r.id = doc.id;
    //       _bookedRooms.add(r);
    //     });
    //     setState(() {});
    //   });
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booked Rooms"),
      ),
      body: ListView.builder(
          itemCount: upcomingRoom.length,
          itemBuilder: (context, idx) {
            var r = upcomingRoom[idx];
            return BookingCard(
              dateRange: r.busyRangeDate ?? "",
              facilities: r.facilities ?? [],
              name: r.name ?? "",
              total: "5000",
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: 1,
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
