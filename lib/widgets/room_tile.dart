import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:home_cultural_renter/data/room.dart';

class RoomTile extends StatelessWidget {
  final Room room;
  const RoomTile({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                room.name ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                room.busyRangeDate ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Text("\tActive")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
