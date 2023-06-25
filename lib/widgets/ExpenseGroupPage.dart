
import 'dart:math';

import 'package:afarms/models/addedFarm.dart';
import 'package:afarms/widgets/pages/addfarm.dart';
import 'package:afarms/widgets/pages/farm_card.dart';
import 'package:afarms/widgets/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color_palette.dart';

import 'farm_expense_card.dart';



class ExpenseGroupPage extends StatefulWidget  {
  final String? name;
  final String? farm;
  ExpenseGroupPage({Key? key, this.name, this.farm}) : super(key: key);


  final TextEditingController _newExpenseGroup = TextEditingController();
  final addedFarm newProduct = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  State<ExpenseGroupPage>  createState() => _ExpenseGroupPageState(name, farm);

}

class  _ExpenseGroupPageState extends State<ExpenseGroupPage> {
  String? name;
  String? farm;
  _ExpenseGroupPageState(this.name,this.farm);
  String code = '';
  @override
  void initState() {
    super.initState();
    generatedCode = generateCode();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String randomCode = '';

  String generatedCode = '';



  String generateCode() {
    // Retrieve farm type and group type from Firestore
    String? farmType = name; // Replace with Firestore document instance
    String? groupType = farm; // Replace with Firestore document instance

    // Extract first and third letters of farm type
    String firstLetter = farmType!.substring(0, 1);
    String thirdLetter = farmType.substring(2, 3).toUpperCase();
    String firsttwo=groupType!.substring(0,2).toUpperCase();

    // Generate random code
    Random random = Random();
    String randomCode = '';
    for (int i = 0; i < 4; i++) {
      randomCode += random.nextInt(10).toString();
    }

    // Concatenate farm type letters, random code, and group type
    String finalCode =firsttwo+"-"+ firstLetter + thirdLetter + randomCode  ;

    return finalCode;
  }



  // void LoadCode()  async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedCode = prefs.getString('randomCode');
  //   // Generate a random 4-digit code
  //
  //   if (storedCode != null) {
  //     setState(() {
  //       randomCode = storedCode;
  //     });
  //   }
  //   else {
  //     String newRandomCode = _generateRandomCode();
  //     setState(() {
  //       randomCode = newRandomCode;
  //     });
  //
  //     await prefs.setString('randomCode', newRandomCode);
  //   }
  // }
  //
  //
  //   String _generateRandomCode() {
  //
  //   String code = '';
  //
  //
  //   Random random = Random();
  //   int randomNumber = random.nextInt(9000) + 1000;
  //   const int codeLength = 10;
  //   const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  //
  //   for (int i = 0; i < codeLength; i++) {
  //   code += chars[random.nextInt(chars.length)];
  //
  //
  //
  //   if (farm == "Winneba") {
  //     code = "WN-$randomNumber";
  //
  //     setState(() {
  //       // else if(newProduct.group=="Tachiam"){
  //
  //       //   code = "TA-"+randomNumber.toString();
  //       // } else if(newProduct.group=="Nankese"){
  //       //   code = "NA-"+randomNumber.toString();
  //       // }
  //       code = "WN-" + randomNumber.toString();
  //     });
  //   } else if (farm == "Tachiam") {
  //     code = "TA-" + randomNumber.toString();
  //     setState(() {
  //       // } else if(newProduct.group=="Nankese"){
  //       //   code = "NA-"+randomNumber.toString();
  //       // }
  //       code = "TA-" + randomNumber.toString();
  //     });
  //   } else if (farm == "Nankese") {
  //     code = "NA-" + randomNumber.toString();
  //     setState(() {
  //       // } else if(newProduct.group=="Nankese"){
  //       //   code = "NA-"+randomNumber.toString();
  //       // }
  //       code = "NA-" + randomNumber.toString();
  //     });
  //   }
  //   }
  //
  //   return code;
  //
  //
  // }
  @override
  Widget build(BuildContext context) {

    //
    // String? farmType = name; // Replace with your actual farm type
    // String? groupType = farm; // Replace with your actual group type
    // String customCode = _getCustomCode(farmType!, groupType!);

    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            right: 10,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return addfarm(
                      group: name,
                      Farm: farm,
                    );
                  },
                ),
              );
            },
            splashColor: Colors.black,
            backgroundColor: Colors.black,

            child: const Icon(
              Icons.add,
              color: ColorPalette.white,
            ),
          ),
        ),
        body:

                      Container(
                        color: ColorPalette.aquaHaze,
                        child: SafeArea(
                          child: Container(
                            color: ColorPalette.aquaHaze,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                    right: 15,
                                  ),
                                  width: double.infinity,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    color: ColorPalette.aquaHaze,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.chevron_left_rounded,
                                              size: 35,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          Text(
                                            name!.length > 14
                                                ? '${name!.substring(0, 12)}..'
                                                : name!,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 28,
                                              color: ColorPalette.timberGreen,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            splashColor: ColorPalette.timberGreen,
                                            icon: const Icon(
                                              Icons.search,
                                              color: ColorPalette.timberGreen,
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         SearchProductInGroupPage(
                                              //       name: name,
                                              //     ),
                                                //),
                                              //);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: ColorPalette.timberGreen,
                                            ),
                                            onPressed: () {
                                              //TODO
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            "Expenses",
                                            style: TextStyle(
                                              color: ColorPalette.timberGreen,
                                              fontSize: 20,
                                              fontFamily: "Nunito",
                                            ),
                                          ),
                                           Text(
                                            farm!,
                                            style: TextStyle(
                                              color: ColorPalette.timberGreen,
                                              fontSize: 20,
                                              fontFamily: "Nunito",
                                            ),
                                          ),
                                          //
                                          //  Text("Code:"+
                                          //      '$generatedCode',
                                          //   style: TextStyle(
                                          //     color: ColorPalette.timberGreen,
                                          //     fontSize: 20,
                                          //     fontFamily: "Nunito",
                                          //   ),
                                          // ),
                                          const SizedBox(height: 20),

                                          // Text("${newProduct.farmcode}"),
                                          const SizedBox(height: 20),
                                          Expanded(
                                            child: StreamBuilder(
                                              stream: _firestore
                                                  .collection("Expenses")
                                                  .where("Farm", isEqualTo: farm).where("ExpenseType",isEqualTo:name)

                                                  .snapshots(),
                                              builder: (
                                                BuildContext context,
                                                AsyncSnapshot<
                                                        QuerySnapshot<Map<String, dynamic>>>
                                                    snapshot,
                                              ) {
                                                if (!snapshot.hasData) {
                                                  return  Center(
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return ListView.builder(
                                                  itemCount: snapshot.data!.docs.length,
                                                  itemBuilder:
                                                      (BuildContext context, int index) {
                                                    return FarmCard(
                                                    Farm: addedFarm.fromMap( snapshot.data!.docs[index].data(),),
                                                    docID: snapshot.data!.docs[index].id,
                                                    );
                                                  },
                                                );

                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
  }
}
