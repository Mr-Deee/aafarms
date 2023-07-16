import 'dart:ui';

import 'package:afarms/widgets/pages/allexpenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/addedFarm.dart';
import '../farm_group_card.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final TextEditingController _newProductGroup = TextEditingController();

  final addedFarm newfarm = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/back2.png'),
            // Replace with your image path
            fit: BoxFit.cover,
          ),),

            child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Container(


              padding: const EdgeInsets.symmetric(horizontal: 10.0),







              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 1)
                      .withOpacity(_opacity),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30)),

              ),

              child: Column(
                children: [
                  SizedBox(height: 30,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                  borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              "A-fARMS",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Sign Out'),
                                      backgroundColor: Colors.white,
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Text('Are you certain you want to Sign Out?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            print('yes');
                                            FirebaseAuth.instance.signOut();
                                            Navigator.pushNamedAndRemoveUntil(
                                                context, "/SignIn", (route) => false);
                                            // Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
                    Column(
                        children: [

                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 10,
                            right: 15,
                          ),
                          width: 150,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white54,
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
                                  Text(
                                    "Hi",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 58.0),
                                    child: Text("Welcome"),
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
                                                      BorderRadius.circular(
                                                          20.0)),
                                              //this right here
                                              child: Container(
                                                  height: 250,
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
                                                              "Add A FARM",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
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
                                                                  child:
                                                                      TextField(
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    key:
                                                                        UniqueKey(),
                                                                    controller:
                                                                        _newProductGroup,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Nunito",
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Product Group Name",
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors.white54
                                                                              ,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    cursorColor:
                                                                        Colors
                                                                            .white54,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (_newProductGroup.text !=
                                                                            null &&
                                                                        _newProductGroup.text !=
                                                                            "") {
                                                                      try {
                                                                        final DocumentSnapshot<
                                                                            Map<String,
                                                                                dynamic>> _doc = await _firestore
                                                                            .collection("utils")
                                                                            .doc("FarmGroups")
                                                                            .get();
                                                                        final List<dynamic>
                                                                            _tempList =
                                                                            _doc.data()!['list']
                                                                                as List<dynamic>;
                                                                        if (_tempList
                                                                            .contains(_newProductGroup.text)) {
                                                                          displayToast(
                                                                            "Group Name already created",
                                                                            context,
                                                                          );
                                                                        } else {
                                                                          _tempList
                                                                              .add(_newProductGroup.text);
                                                                          _firestore
                                                                              .collection(
                                                                                  'utils')
                                                                              .doc(
                                                                                  "FarmGroups")
                                                                              .update({
                                                                            'list':
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
                                                                      _newProductGroup
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
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return allexpenses();
                        }));},


                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 10,
                              right: 15,
                            ),
                            width: 150,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white54,
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
                                Column(
                                  children: [
                                    // Text(
                                    //   "",
                                    //   style: TextStyle(
                                    //       fontSize: 30,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 58.0),
                                      child: Text("EXPENSES",style: TextStyle(fontSize: 24),),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _firestore.collection("utils").snapshots(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot,
                      ) {
                        if (snapshot.hasData) {
                          final List<dynamic> _productGroups =
                              snapshot.data!.docs[0].data()['list']
                                  as List<dynamic>;
                          _productGroups.sort();
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: _productGroups.length,
                            itemBuilder: (context, index) {
                              return farmGroupCard(
                                name: _productGroups[index] as String,
                                key: UniqueKey(),
                              );
                            },
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
                ],
              ),
            ),
          ),
        )));
    ;
  }
}

displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
