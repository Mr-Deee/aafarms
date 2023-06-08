import 'package:afarms/widgets/pages/farm_group_page.dart';
import 'package:flutter/material.dart';


class farmGroupCard extends StatelessWidget {
  final String? name;

  const farmGroupCard({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return FarmGroupPage(
                name: name,
              );
            },
          ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 6,
                  color: const Color(0xff000000).withOpacity(0.16),
                ),
              ],
            ),
            child: Text(
              name!,
              style: const TextStyle(
                fontFamily: "Nunito",
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // TODO: Add counter
          ),
        ),
      ),
    );
  }
}
