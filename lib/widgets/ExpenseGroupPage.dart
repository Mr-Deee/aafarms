import 'dart:math';
import 'dart:ui';

import 'package:afarms/models/addedFarm.dart';
import 'package:afarms/widgets/pages/addfarm.dart';
import 'package:afarms/widgets/pages/farm_card.dart';
import 'package:afarms/widgets/pages/farm_group_page.dart';
import 'package:afarms/widgets/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../color_palette.dart';

class ExpenseGroupPage extends StatefulWidget {
  final String? name;
  final String? farm;
  final String? finalCode;
  ExpenseGroupPage({Key? key, this.name, this.finalCode,this.farm}) : super(key: key);

  final TextEditingController _newExpenseGroup = TextEditingController();
  final addedFarm newProduct = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? docID;

  @override
  State<ExpenseGroupPage> createState() => _ExpenseGroupPageState(name, farm,docID,finalCode);
}

class _ExpenseGroupPageState extends State<ExpenseGroupPage> {
  String? name;
  String? farm;


   String? docID;
  _ExpenseGroupPageState(this.name, this.farm, this.docID,this.finalCode);
  var field1;
  var field2;
  String code = '';
  String farmcode="";

  @override
  void initState() {
    super.initState();
    genCode();
    fetchData();
  }
  void fetchData() async {
    FirebaseFirestore.instance
        .collection('FarmCode')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.size > 0) {
        // Iterate over the list of documents
        for (var doc in snapshot.docs) {
          var documentData = doc.data();
          // Access the fields within the documentData map
           field1 = documentData['ExpenseName'];
           field2 = documentData['FarmCode'];
          // Do something with the retrieved document fields
          print('Field 1: $field1');
          print('Field 2: $field2');



          if(field1==name){
            setState(() {
              finalCode=field2;
            });

          }
        }
      } else {
        print('No documents found in the collection.');
      }
    }).catchError((error) {
      print('Error getting documents: $error');
    });
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
    String firsttwo = groupType!.substring(0, 2).toUpperCase();

    // Generate random code
    Random random = Random();
    String randomCode = '';
    for (int i = 0; i < 4; i++) {
      randomCode += random.nextInt(10).toString();
    }

    // Concatenate farm type letters, random code, and group type
    String finalCode = firsttwo + "-" + firstLetter + thirdLetter + randomCode;

    return finalCode;
  }
  String? finalCode;
  String? genCode() {


    if(field1==name){

    setState(() {
      finalCode=field2;
    });
    return finalCode;

  }
    // Generate random code


    // Concatenate farm type letters, random code, and group type


  }

  @override
  Widget build(BuildContext context) {
    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
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



        body: Container(
            color: ColorPalette.aquaHaze,
            child: SafeArea(
                child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/back2.png'),
                  // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
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
                                  // IconButton(
                                  //   splashColor: ColorPalette.timberGreen,
                                  //   icon: const Icon(
                                  //     Icons.search,
                                  //     color: ColorPalette.timberGreen,
                                  //   ),
                                  //   onPressed: () {
                                  //     // Navigator.of(context).push(
                                  //     //   MaterialPageRoute(
                                  //     //     builder: (context) =>
                                  //     //         SearchProductInGroupPage(
                                  //     //       name: name,
                                  //     //     ),
                                  //     //),
                                  //     //);
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: ColorPalette.timberGreen,
                                    ),
                                    onPressed: () {



                                      _firestore
                                          .collection("ExpenseList")
                                          .doc("ExpenseGroup").collection("List").doc(docID)
                                          .delete()
                                          .then((value) {
                                        displayToast('Deleted Sucessfully!', context);
                                      }).catchError((e) {
                                        displayToast('Failed!', context);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(_opacity),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),


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
                                    // Text(
                                    //   farm!,
                                    //   style: TextStyle(
                                    //     color: ColorPalette.timberGreen,
                                    //     fontSize: 20,
                                    //     fontFamily: "Nunito",
                                    //   ),
                                    // ),


                                    Text(
                                      "bnn$finalCode",
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: MediaQuery.of(context).size.height*0.6,
                                      child: StreamBuilder(
                                        stream: _firestore
                                            .collection("Expenses")
                                            .where("Farm", isEqualTo: farm)
                                            .where("ExpenseType", isEqualTo: name)
                                            .snapshots(),
                                        builder: (
                                          BuildContext context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot,
                                        ) {
                                          if (!snapshot.hasData) {
                                            return Center(
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return FarmCard(
                                                Farm: addedFarm.fromMap(
                                                  snapshot.data!.docs[index]
                                                      .data(),
                                                ),
                                                docID:
                                                    snapshot.data!.docs[index].id,
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
                    )),
              )],
                    ),
                  ),
                ),
              ),
            );
  }


}
