import 'package:afarms/widgets/ExpenseGroupPage.dart';
import 'package:afarms/widgets/pages/farm_group_page.dart';
import 'package:flutter/material.dart';


class farmExpensesCard extends StatelessWidget {
  final String? name;
  final String?  Farm;


  const farmExpensesCard({Key? key, this.name, required, this.Farm }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ExpenseGroupPage(
                name: name,
                key: UniqueKey(),
                farm: Farm
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
            child: Column(
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Row(children:[
                //   Text("${}")
                // ])
              ],
            ),
            // TODO: Add counter
          ),
        ),
      ),
    );
  }
}
