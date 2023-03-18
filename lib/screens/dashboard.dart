import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:home_cultural_renter/data/facility.dart';
import 'package:home_cultural_renter/widgets/room_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/room.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Room> _rooms = [];

  List<Room> todayRoom = [
    Room.arg(
        "id",
        "Manish Shah",
        "landmarkPlaceId",
        "17/03/2023 - 19/03/2023",
        "description",
        "lightBillId",
        [Facility("Room", 2000), Facility("food", 1000)])
  ];
  List<Room> upcomingRoom = [
    Room.arg(
        "id",
        "Ganesh Wagh",
        "landmarkPlaceId",
        "21/03/2023 - 27/03/2023",
        "description",
        "lightBillId",
        [Facility("Room", 2500), Facility("food", 1000)]),
    Room.arg(
        "id",
        "Ram Puri",
        "landmarkPlaceId",
        "28/03/2023 - 30/03/2023",
        "description",
        "lightBillId",
        [Facility("Room", 3500), Facility("food", 2000)])
  ];
  @override
  void initState() {
    super.initState();

    //TODO: Fetch Rooms of this user
    _rooms = Room.mockRooms();
    setState(() {});
  }
  /*ListView.builder(
          itemCount: _rooms.length,
          itemBuilder: (context, idx) => RoomTile(room: _rooms[idx])) */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 47, left: 12),
              child: Text(
                "Lata, Your Weekly Schedule",
                style: GoogleFonts.poppins(fontSize: 17),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 37),
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Schedule",
                style: GoogleFonts.poppins(fontSize: 56),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 36),
              padding: const EdgeInsets.all(4.0),
              child: Text("Today,", style: GoogleFonts.poppins(fontSize: 32)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .35,
              child: ListView.builder(
                  itemCount: todayRoom.length,
                  itemBuilder: (ctx, idx) {
                    var r = todayRoom[idx];
                    return BookingCard(
                      dateRange: r.busyRangeDate ?? "",
                      facilities: r.facilities ?? [],
                      name: r.name ?? "",
                      total: "5000",
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(left: 36),
              padding: const EdgeInsets.all(4.0),
              child: Text("Books ahead,",
                  style: GoogleFonts.poppins(fontSize: 32)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .35,
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (ctx, idx) {
                    var r = upcomingRoom[idx];
                    return BookingCard(
                      dateRange: r.busyRangeDate ?? "",
                      facilities: r.facilities ?? [],
                      name: r.name ?? "",
                      total: "5000",
                    );
                  }),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/upload_space_screen");
          },
          child: const Icon(Icons.add_home)),*/
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
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
                {
                  if (FirebaseAuth.instance.currentUser != null)
                    Navigator.of(context).pushNamed("/profile");
                  break;
                }

              case 3:
                {
                  // if (FirebaseAuth.instance.currentUser != null)
                  Navigator.of(context).pushNamed('/upload_space_screen');
                  break;
                }
              default:
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BookingCard extends StatelessWidget {
  bool rejectable = false;
  String name = "Manish Shah",
      dateRange = "12/03/2023 - 15/05/2023",
      address = "Saraswati Niwas",
      total = "5000";
  List<Facility> facilities = [];
  BookingCard(
      {super.key,
      this.rejectable = false,
      required this.name,
      required this.dateRange,
      required this.total,
      required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      color: Color.fromARGB(255, 206, 206, 206),
      elevation: 12,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
                Text(dateRange)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Services Opted"),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              child: ListView.builder(
                  itemCount: facilities.length,
                  itemBuilder: (ctx, idx) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(facilities[idx].facility),
                        Text(facilities[idx].amount.toString())
                      ],
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  label: Text(address),
                  backgroundColor: Colors.orange,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Total:",
                  ),
                  TextSpan(
                      text: total,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]))
              ],
            ),
            if (rejectable)
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Reject"),
                ),
              )
          ],
        ),
      ),
    );
  }
}
