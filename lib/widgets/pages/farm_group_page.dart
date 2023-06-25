
import 'dart:ui';

import 'package:afarms/models/addedFarm.dart';
import 'package:afarms/widgets/pages/farm_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../color_palette.dart';
import '../farm_expense_card.dart';
import 'addfarm.dart';
import 'homepage.dart';



class FarmGroupPage extends StatelessWidget {
  final String? name;
  FarmGroupPage({Key? key, this.name}) : super(key: key);


  final TextEditingController _newExpenseGroup = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {


    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
    return Scaffold(

      body:      SafeArea(
        child: Container(

          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage('assets/images/backdrop.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),),
          child: Column(
              children: [
          Row(
          children: [
          Padding(
          padding: const EdgeInsets.only(
              top:10.0,
              left: 10,
              right:10),
          child: Container(

            padding: const EdgeInsets.only(
              top: 0,
              left: 10,
              right: 15,
            ),
            width: 170,
            height: 160,

            decoration:  BoxDecoration(
              color:  Colors.white38.withOpacity(0.56),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),

              boxShadow: [
                BoxShadow(
                  offset:  Offset(0, 5),
                  blurRadius: 6,
                  color:  Color(0xff000000).withOpacity(0.16),
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Text("Create Expense\nCategory",
                      style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black),),
                    ),



                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(



                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(

                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                    height: 250,
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "ADD EXPENSE",
                                                style: TextStyle(fontFamily: "Nunito",fontSize: 35,fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [


                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:Colors.white54,
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(0, 3),
                                                          blurRadius: 6,
                                                          color: const Color(0xff000000).withOpacity(0.16),
                                                        ),
                                                      ],
                                                    ),
                                                    height: 50,
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          textInputAction: TextInputAction.next,
                                                          key: UniqueKey(),
                                                          controller: _newExpenseGroup,
                                                          keyboardType: TextInputType.text,
                                                          style: const TextStyle(
                                                            fontFamily: "Nunito",
                                                            fontSize: 16,
                                                            color: Colors.black38,
                                                          ),
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: "Expense Name",
                                                            filled: true,
                                                            fillColor: Colors.white54,
                                                            hintStyle: TextStyle(
                                                              fontFamily: "Nunito",
                                                              fontSize: 16,
                                                              color: Colors.black38,
                                                            ),
                                                          ),
                                                          cursorColor: Colors.black38,
                                                        ),



                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (_newExpenseGroup.text != null &&
                                                          _newExpenseGroup.text != "") {
                                                        try {
                                                          final DocumentSnapshot<Map<String, dynamic>>
                                                          _doc = await _firestore
                                                              .collection("ExpenceList")
                                                              .doc("ExpenseGroup")
                                                              .get();
                                                          final List<dynamic> _tempList =
                                                          _doc.data()!['List'] as List<dynamic>;
                                                          if (_tempList.contains(_newExpenseGroup.text)) {
                                                            displayToast("Group Name already created",context,);
                                                          } else {
                                                            _tempList.add(_newExpenseGroup.text);
                                                            _firestore
                                                                .collection('ExpenceList')
                                                                .doc("ExpenseGroup")
                                                                .update({'List': _tempList});
                                                            displayToast("Added Successfully",context,);
                                                          }
                                                        } catch (e) {
                                                          displayToast("An Error Occured!",context,);
                                                        }
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context).pop();
                                                        _newExpenseGroup.text = "";
                                                      } else {
                                                        displayToast("Enter Valid Name!",context,);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.black,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: const Offset(0, 3),
                                                            blurRadius: 6,
                                                            color:
                                                            const Color(0xff000000).withOpacity(0.16),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Done",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: "Nunito",
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]))));
                          },
                        );
                      },
                      // onTap: (){
                      //   Navigator.pushNamed(
                      //       context,"/addproduct");
                      //
                      // },
                      child: Icon(Icons.add,
                        color:   Color.fromRGBO(216, 78, 16, 1),
                      size: 50,)),
                ),


              ],
            ),

          ),
        ),
        ],
      ),

      SizedBox(height: 19,),
        Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(
                    top:10.0,
                    left: 10,
                    right:10),

                  // decoration:  BoxDecoration(

                  // ),



                ),
              ClipRect(
                child: BackdropFilter(
                  filter:
                  ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),

                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(_opacity),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.6,
                  child:    Container(
                    height :MediaQuery.of(context).size.height * 0.6,
                    child: StreamBuilder(
                      stream:
                      _firestore.collection("ExpenceList").snapshots(),
                      builder: (
                          BuildContext context,
                          AsyncSnapshot<
                              QuerySnapshot<Map<String, dynamic>>>
                          snapshot,
                          ) {
                        if (snapshot.hasData) {
                          final List<dynamic> _productGroups =
                          snapshot.data!.docs[0].data()['List']
                          as List<dynamic>;
                          _productGroups.sort();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: _productGroups.length,
                              itemBuilder: (context, index) {
                                return farmExpensesCard(
                                  name: _productGroups[index] as String,
                                  key: UniqueKey(),
                                  Farm: name,

                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),




                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //
                  //         Padding(
                  //           padding: const EdgeInsets.only(top:18.0),
                  //           child: Text(name!+" -Farm"),
                  //         ),
                  //
                  //         Column(
                  //           children: [
                  //
                  //           ],
                  //         ),
                  //
                  //       ],
                  //     ),
                  //
                  //
                  //
                  //   ],
                  // ),
    )
                ),
              ),
            ],),






      // Container(
      //   color: ColorPalette.aquaHaze,
      //   child: SafeArea(
      //     child: Container(
      //       color: ColorPalette.aquaHaze,
      //       height: double.infinity,
      //       width: double.infinity,
      //       child: Column(
      //         children: [
      //           Container(
      //             padding: const EdgeInsets.only(
      //               top: 10,
      //               left: 10,
      //               right: 15,
      //             ),
      //             width: double.infinity,
      //             height: 90,
      //             decoration: const BoxDecoration(
      //               color: ColorPalette.aquaHaze,
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(16),
      //                 bottomRight: Radius.circular(16),
      //               ),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     IconButton(
      //                       icon: const Icon(
      //                         Icons.chevron_left_rounded,
      //                         size: 35,
      //                       ),
      //                       onPressed: () {
      //                         Navigator.of(context).pop();
      //                       },
      //                     ),
      //                     Text(
      //                       name!.length > 14
      //                           ? '${name!.substring(0, 12)}..'
      //                           : name!,
      //                       style: const TextStyle(
      //                         fontFamily: "Nunito",
      //                         fontSize: 28,
      //                         color: ColorPalette.timberGreen,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     IconButton(
      //                       splashColor: ColorPalette.timberGreen,
      //                       icon: const Icon(
      //                         Icons.search,
      //                         color: ColorPalette.timberGreen,
      //                       ),
      //                       onPressed: () {
      //                         // Navigator.of(context).push(
      //                         //   MaterialPageRoute(
      //                         //     builder: (context) =>
      //                         //         SearchProductInGroupPage(
      //                         //       name: name,
      //                         //     ),
      //                           //),
      //                         //);
      //                       },
      //                     ),
      //                     IconButton(
      //                       icon: const Icon(
      //                         Icons.delete,
      //                         color: ColorPalette.timberGreen,
      //                       ),
      //                       onPressed: () {
      //                         //TODO
      //                       },
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 20),
      //               child: SizedBox(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       children: const [
      //                         SizedBox(
      //                           height: 20,
      //                         ),
      //                       ],
      //                     ),
      //                     const Text(
      //                       "Expenses",
      //                       style: TextStyle(
      //                         color: ColorPalette.timberGreen,
      //                         fontSize: 20,
      //                         fontFamily: "Nunito",
      //                       ),
      //                     ),
      //                     const SizedBox(height: 20),
      //                     Expanded(
      //                       child: StreamBuilder(
      //                         stream: _firestore
      //                             .collection("Expenses")
      //                             .where("group", isEqualTo: name)
      //
      //                             .snapshots(),
      //                         builder: (
      //                           BuildContext context,
      //                           AsyncSnapshot<
      //                                   QuerySnapshot<Map<String, dynamic>>>
      //                               snapshot,
      //                         ) {
      //                           if (!snapshot.hasData) {
      //                             return  Center(
      //                               child: SizedBox(
      //                                 height: 40,
      //                                 width: 40,
      //                                 child: CircularProgressIndicator(
      //                                   color: Colors.black,
      //                                 ),
      //                               ),
      //                             );
      //                           }
      //                           return ListView.builder(
      //                             itemCount: snapshot.data!.docs.length,
      //                             itemBuilder:
      //                                 (BuildContext context, int index) {
      //                               return FarmCard(
      //                               Farm: addedFarm.fromMap( snapshot.data!.docs[index].data(),),
      //                               docID: snapshot.data!.docs[index].id,
      //                               );
      //                             },
      //                           );
      //
      //                         },
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    ]))));
  }
}
