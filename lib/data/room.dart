import 'dart:convert';

import 'package:home_cultural_renter/data/facility.dart';

class Room {
  String? id, name, landmarkPlaceId, busyRangeDate, description, lightBillId;
  List<Facility>? facilities;
  factory Room.arg(id, name, landmarkPlaceId, busyRangeDate, description,
      lightBillId, facilities) {
    var r = Room();
    r.id = id;
    r.name = name;
    r.landmarkPlaceId = landmarkPlaceId;
    r.busyRangeDate = "";
    r.description = description;
    r.lightBillId = lightBillId;
    r.facilities = [];
    return r;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "landmarkId": landmarkPlaceId,
      "busyRangeDate": busyRangeDate,
      "description": description,
      "lightBillId": lightBillId,
      "facilities": json.encode(facilities)
    };
  }

  factory Room.fromMap(Map doc) {
    var m = Room();
    m.id = doc["id"];
    m.name = doc["name"];
    m.busyRangeDate = doc["busyRangeDate"];
    m.description = doc["description"];
    m.lightBillId = doc['lightBillId'];
    m.facilities = json.decode(doc['facilities']);
    return m;
  }

  Room();

//TODO: Calc Date
  bool isActive() => true;

  factory Room.mock() => Room.arg(
      "id",
      "name",
      "landmarkPlaceId",
      "busyRangeDate",
      "description",
      "lightBillId",
      [Facility("accomodation", 2000.0)]);

  static List<Room> mockRooms() {
    return [
      Room.arg("id", "Farm House", "landmarkPlaceId", "12-03-2023 16-03-2023",
          "description", "lightBillId", []),
      Room.arg("id", "River House", "landmarkPlaceId", "12-03-2023 16-03-2023",
          "description", "lightBillId", []),
      Room.arg("id", "Beach House", "landmarkPlaceId", "12-03-2023 16-03-2023",
          "description", "lightBillId", []),
    ];
  }
}
