import 'package:home_cultural_renter/data/facility.dart';

class Booking {
  String traveler;
  String dateRange;
  List<Facility> optedServices;
  String roomId;

  Booking(this.traveler, this.dateRange, this.optedServices, this.roomId);

  double getTotal() {
    double total = 0;
    for (var i = 0; i < optedServices.length; i++) {
      total += optedServices[i].amount;
    }
    return total;
  }
}
