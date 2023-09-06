import 'dart:ui';

import 'package:afarms/models/addedFarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../farm_expense_card.dart';
import 'homepage.dart';

class FarmGroupPage extends StatefulWidget {
  final String? name;

  FarmGroupPage({Key? key, this.name}) : super(key: key);

  @override
  State<FarmGroupPage> createState() => _FarmGroupPageState(
        name,
      );
}

final TextEditingController _newExpenseGroup = TextEditingController();

String? currentSelectedValue;
List<String> FARMCODE = [
  "NA-JNJ028(Nankese|Pesticide)",
  "NA-JNJ025(Nankese|Fertilizer)",
  "NA-JNJ026(Nankese|Transport)",
  "NA-JNJ027(Nankese|Fuel)",
  "WN-JNJ015(Winneba|Pesticide)",
  "WN-JNJ016(Winneba|Transport)",
  "WN-JNJ017(Winneba|Fertilizer)",
  "WN-JNJ018(Winneba|Fuel)",
  "TA-JNJ019(Tachiam|Pesticide)",
  "TA-JNJ020(Tachiam|Transport)",
  "TA-JNJ021(Tachiam|Fertilizer)",
  "TA-JNJ022(Tachiam|Fuel)",

  // " WN-JNJ029()",
  // "TA-JNJ029",
  // " NA-JNJ029"
];

final addedFarm newProduct = addedFarm();

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _FarmGroupPageState extends State<FarmGroupPage> {
  _FarmGroupPageState(
    this.name,
  );

  String? name;

  @override
  Widget build(BuildContext context) {
    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backdrop.png'),
                    // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 35, right: 30),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 10,
                            right: 15,
                          ),
                          width: 170,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white38.withOpacity(0.56),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 6,
                                color: Color(0xff000000).withOpacity(0.16),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 28.0),
                                    child: Text(
                                      "Create Expense\nCategory",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                name!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
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
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //this right here
                                              child: Container(
                                                  height: 300,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "ADD EXPENSE",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("To"),
                                                            Text(
                                                              name!,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            StatefulBuilder(builder:
                                                                (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white54,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            String>(
                                                                  icon: Visibility(
                                                                      visible:
                                                                          false,
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_downward)),
                                                                  iconSize: 4,
                                                                  elevation:
                                                                      16, // game changer
                                                                  hint: Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: const Text(
                                                                        "Select A Code"),
                                                                  ),
                                                                  value:
                                                                      currentSelectedValue,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      currentSelectedValue =
                                                                          newValue;
                                                                      newValue =
                                                                          newProduct
                                                                              .farmcode;
                                                                    });
                                                                  },
                                                                  items: FARMCODE.map<
                                                                      DropdownMenuItem<
                                                                          String>>((String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                            String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value));
                                                                  }).toList(),
                                                                )),
                                                              );
                                                            }),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white54,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        offset: const Offset(
                                                                            0,
                                                                            3),
                                                                        blurRadius:
                                                                            6,
                                                                        color: const Color(0xff000000)
                                                                            .withOpacity(0.16),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  height: 50,
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        key:
                                                                            UniqueKey(),
                                                                        controller:
                                                                            _newExpenseGroup,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              "Nunito",
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black38,
                                                                        ),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintText:
                                                                              "Expense Name",
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white54,
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Nunito",
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black38,
                                                                          ),
                                                                        ),
                                                                        cursorColor:
                                                                            Colors.black38,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    codefordb();
                                                                    if (_newExpenseGroup.text !=
                                                                            null &&
                                                                        _newExpenseGroup.text !=
                                                                            "") {
                                                                      try {
                                                                        final DocumentSnapshot<
                                                                            Map<String,
                                                                                dynamic>> _doc = await _firestore
                                                                            .collection("ExpenseList")
                                                                            .doc("ExpenseGroup")
                                                                            .get();
                                                                        final List<dynamic>
                                                                            _tempList =
                                                                            _doc.data()!['List']
                                                                                as List<dynamic>;
                                                                        if (_tempList
                                                                            .contains(_newExpenseGroup.text)) {
                                                                          // _tempList
                                                                          //     .add(_newExpenseGroup.text);
                                                                          _firestore
                                                                              .collection(
                                                                                  'ExpenseList')
                                                                              .doc(
                                                                                  "ExpenseGroup")
                                                                              .update({
                                                                            'List':
                                                                                _tempList
                                                                          });
                                                                          displayToast(
                                                                            "Added Successfully",
                                                                            context,
                                                                          );
                                                                          // displayToast(
                                                                          //   "Group Name already created",
                                                                          //   context,
                                                                          // );
                                                                        } else {
                                                                          _tempList
                                                                              .add(_newExpenseGroup.text);
                                                                          _firestore
                                                                              .collection(
                                                                                  'ExpenseList')
                                                                              .doc(
                                                                                  "ExpenseGroup")
                                                                              .update({
                                                                            'List':
                                                                                _tempList
                                                                          });
                                                                          displayToast(
                                                                            "Added Successfully",
                                                                            context,
                                                                          );
                                                                        }
                                                                      } catch (e) {
                                                                        displayToast(
                                                                          "An Error Occured!",
                                                                          context,
                                                                        );
                                                                      }
                                                                      // ignore: use_build_context_synchronously
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      _newExpenseGroup
                                                                          .text = "";
                                                                    } else {
                                                                      displayToast(
                                                                        "Enter Valid Name!",
                                                                        context,
                                                                      );
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 45,
                                                                    width: 90,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Colors
                                                                          .black,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                          blurRadius:
                                                                              6,
                                                                          color:
                                                                              const Color(0xff000000).withOpacity(0.16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Done",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontFamily:
                                                                              "Nunito",
                                                                          color:
                                                                              Colors.white,
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
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromRGBO(216, 78, 16, 1),
                                      size: 20,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10, right: 10),

                        // decoration:  BoxDecoration(

                        // ),
                      ),
                      ClipRect(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: _sigmaX, sigmaY: _sigmaY),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 1)
                                      .withOpacity(_opacity),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: StreamBuilder(
                                  stream: _firestore
                                      .collection("ExpenseList")
                                      .snapshots(),
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
                                              name: _productGroups[index]
                                                  as String,
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
                            )),
                      ),
                    ],
                  ),
                ]))));
  }

  codefordb() {
    FirebaseFirestore.instance.collection('FarmCode').doc().set({
      // 'MobileNumber': _mobileNumber.toString().trim(),
      // 'fullName':_firstName! +  _lastname!,
      'FarmCode': currentSelectedValue,
      'ExpenseName': _newExpenseGroup.text,
      'FarmName': name!,
      // 'Gender': Gender,
      // 'Date Of Birth': birthDate,
    });

    //String? url = await  uploadImage(selectedImagePath!);

    // Farms.child("Farm").set(userDataMap);
  }
}
