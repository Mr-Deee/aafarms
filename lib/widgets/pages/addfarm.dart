import 'dart:io';
import 'dart:io' as io;
import 'dart:math';

import 'package:afarms/models/addedFarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../../color_palette.dart';
import '../../main.dart';
import '../../toast.dart';
import '../progressDialog.dart';

class addfarm extends StatefulWidget {
  const addfarm({Key? key, this.group, this.Farm, this.FinalCode})
      : super(key: key);
  final String? group;
  final String? FinalCode;
  final String? Farm;

  @override
  State<addfarm> createState() => _addfarmState(group, Farm, FinalCode);
}

class _addfarmState extends State<addfarm> {
  @override
  void initState() {
    super.initState();
    generateCode();
    FinalCode;
  }

  String? FinalCode;

  List<File> _image = [];
  String? _selectedImage;
  String? group;
  String? farm;

  _addfarmState(this.group, this.farm, this.FinalCode);

  // final picker = ImagePicker();
  double val = 0;

  // final ImagePicker imagePicker = ImagePicker();
  bool uploading = false;
  final addedFarm newProduct = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  File? selectedfile;

  // void _selectImage1(String image) {
  //   setState(() {
  //     _selectedImage = image;
  //     _selectedImage == selectedfile;
  //   });
  // }
  String code = '';
  String randomCode = '';

  String generatedCode = '';

  String generateCode() {
    // Retrieve farm type and group type from Firestore
    String? farmType = group; // Replace with Firestore document instance
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

  String? currentSelectedValue;
  List<String> FARMCODE = [
    "NA-JNJ028(Nankese|Pesticide)",
    "NA-JNJ025(Nankese|Fertilizer)",
    "NA-JNJ026(Nankese|Transport)",
    "WN-JNJ014(Winneba|Fuel)",
    " WN-JNJ029()",
    "TA-JNJ029",
    " NA-JNJ029"
  ];
  final storage = FirebaseStorage.instance;
  final storageReference = FirebaseStorage.instance.ref();

  String? selectedImagePath;
  String? uploadedImageUrl;

  @override
  Widget build(BuildContext context) {
    // var firstname = Provider
    //     .of<Users>(context)
    //     .userInfo
    //     ?.id!;
    var newprojectname = newProduct.name;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Color(0xff202020),
        backgroundColor: Colors.white54,
        title: Row(
          children: [
            const Text(
              "New Expense",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 28,
                color: ColorPalette.timberGreen,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog(
                    message: "Adding New Product,Please wait.....",
                  );
                });
            //   String? url = await  uploadImage(selectedImagePath!);
            //    uploadsFile();
            //uploadImage(selectedImagePath!);
            Occupationdb();
            newProduct.group = group;
            _firestore.collection("Expenses").add({
              //
              // 'image': url,
              'ExpenseType': group,
              //'FarmCodep': currentSelectedValue.toString(),
              'FarmCodes': FinalCode,

              //newProduct.name.toString(),
              'description': newProduct.description.toString(),
              'Farm': farm,
              'name': group,
              'Company': newProduct.company.toString(),
              'Cost': newProduct.cost,
              'location': farm,
              'quantity': newProduct.quantity,
              //newProduct.toMap()
            }).then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showTextToast('Added Sucessfully!');
            }).catchError((e) {
              showTextToast('Failed!');
            });
            // Navigator.of(context).pop();
          },
          splashColor: Colors.blue,
          backgroundColor: Colors.white54,
          child: const Icon(
            Icons.done,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/backdrop.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
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
                                height: 10,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 50,
                                  ),
                                  margin: const EdgeInsets.only(top: 75),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffd5e2e3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 12,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                  bottom: 1,
                                                ),
                                                child: Text(
                                                  "Expense : $group",
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 12,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                  bottom: 12,
                                                ),
                                                child: Text(
                                                  "Farm : $farm",
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // DropdownButton<String>(
                                        //   value: currentSelectedValue,
                                        //   hint:
                                        //       new Text("Choose From this List"),
                                        //   items: FARMCODE
                                        //       .map<DropdownMenuItem<String>>(
                                        //           (String value) {
                                        //     return DropdownMenuItem<String>(
                                        //       value: value,
                                        //       child: new Row(
                                        //         children: <Widget>[
                                        //           new Icon(
                                        //             Icons
                                        //                 .home_repair_service_rounded,
                                        //             color: Colors.green,
                                        //           ),
                                        //           new Text(value)
                                        //         ],
                                        //       ),
                                        //     );
                                        //   }).toList(),
                                        //   onChanged: (newvalue) {
                                        //     setState(() {
                                        //       currentSelectedValue = newvalue;
                                        //       newvalue == newProduct.farmcode;
                                        //     });
                                        //   },
                                        // ),

                                        // Padding(
                                        //   padding: const EdgeInsets.all(21.0),
                                        //   child: Text(
                                        //     "Or type your custom code (NA-3455|(Expense))",
                                        //     style: TextStyle(fontSize: 11),
                                        //   ),
                                        // ),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue: FinalCode ?? '',
                                            onChanged: (value) {
                                              FinalCode = value;
                                            },
                                            readOnly: true,
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "${FinalCode}",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Container(
                                        //       decoration: BoxDecoration(
                                        //         color: ColorPalette.white,
                                        //         borderRadius:
                                        //             BorderRadius.circular(12),
                                        //         boxShadow: [
                                        //           BoxShadow(
                                        //             offset: const Offset(0, 3),
                                        //             blurRadius: 6,
                                        //             color: ColorPalette.nileBlue
                                        //                 .withOpacity(0.1),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //       height: 50,
                                        //       child: TextFormField(
                                        //         initialValue: newProduct.name ?? '',
                                        //         onChanged: (value) {
                                        //           newProduct.name = value;
                                        //         },
                                        //         textInputAction:
                                        //             TextInputAction.next,
                                        //         key: UniqueKey(),
                                        //         keyboardType: TextInputType.text,
                                        //         style: const TextStyle(
                                        //           fontFamily: "Nunito",
                                        //           fontSize: 16,
                                        //           color: Colors.black,
                                        //         ),
                                        //         decoration: InputDecoration(
                                        //           border: InputBorder.none,
                                        //           hintText: "Product Name",
                                        //           filled: true,
                                        //           fillColor: Colors.transparent,
                                        //           hintStyle: TextStyle(
                                        //             fontFamily: "Nunito",
                                        //             fontSize: 16,
                                        //             color: Colors.grey,
                                        //           ),
                                        //         ),
                                        //         cursorColor: Colors.black,
                                        //       ),
                                        //     ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.cost == null
                                                          ? ''
                                                          : newProduct.cost
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.cost =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Cost",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: Colors.green,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.quantity ==
                                                              null
                                                          ? ''
                                                          : newProduct.quantity
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.quantity =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Quantity",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.company ?? '',
                                            onChanged: (value) {
                                              newProduct.company = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Company",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            cursorColor: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.description ?? '',
                                            onChanged: (value) {
                                              newProduct.description = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                if (selectedImagePath != null)
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          child: Container(
                                            color: Colors.transparent,
                                            child: SizedBox(
                                              height: 250,
                                              child: Card(
                                                elevation: 8,
                                                shadowColor: Colors.grey,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                        side: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Colors.black)),
                                                child: Container(
                                                  padding: EdgeInsets.all(4),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 100,
                                                    backgroundImage: AssetImage(
                                                        selectedImagePath!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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

  Future<String?> uploadsFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$group/${newProduct.description}/${basename(img.path)}');
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          imgRef?.add({'url': value});
          i++;
        });
      });
    }

    String? downloadUrl;
    downloadUrl = await ref?.getDownloadURL();

    return downloadUrl;
  }

  io.File? image;

  Future<String> uploadFile(io.File image) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context)
    //     {
    //       //return ;
    //     }
    // );

    //   final FirebaseAuth auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;
    //final myUid = user?.uid;

    // final userId = currentfirebaseUser?.email;
    // final _storage = FirebaseStorage.instance;

    String downloadUrl;

    //upload to firebase storage

    Reference ref =
        FirebaseStorage.instance.ref().child("$group/${basename(image.path)}");

    await ref.putFile(image);

    downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  // final String _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
  //
  // Future<String?> uploadImage(String imagePath) async {
  //   // Create a unique file name for the uploaded image
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
  //       '_' +
  //       Path.basename(selectedImagePath.toString());
  //
  //   // Create a storage reference
  //   Reference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('ProductImage/$_firebaseAuth/$fileName');
  //
  //   // TaskSnapshot uploadTask = await storageReference.putFile(
  //   //     AssetImage(imagePath));
  //   // Get the asset bundle to read the asset image data
  //   final ByteData byteData = await rootBundle.load(imagePath);
  //   final Uint8List imageData = byteData.buffer.asUint8List();
  //   UploadTask uploadTask = storageReference.putData(imageData);
  //
  //
  //   // Optional: Listen for upload progress
  //   uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
  //     final downloadUrl = await storageReference.getDownloadURL();
  //     //
  //     // clients.child(_firebaseAuth).update({
  //     //   "": downloadUrl,
  //     // });
  //     //
  //
  //
  //     double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
  //     print('Upload progress: $progress%');
  //   }, onError: (Object e) {
  //     print('Upload error: $e');
  //   });
  //
  //   // Wait for the upload to complete
  //   await uploadTask.whenComplete(() {
  //     print('Upload complete');
  //   });
  //   String? downloadUrl;
  //   downloadUrl = await storageReference.getDownloadURL();
  //
  //   return downloadUrl;
  //
  // }

  Occupationdb() async {
    //String? url = await  uploadImage(selectedImagePath!);
    Map userDataMap = {
      'ProductImage': url.toString(),
      'name': group,
      //newProduct.name.toString(),
      'description': newProduct.description.toString(),
      'group': newProduct.group.toString(),
      'Company': newProduct.company.toString(),
      'Cost': newProduct.cost,
      // 'Location': _currentAddress?.trim().toString(),
      'quantity': newProduct.quantity.toString(),
    };

    Farms.child("Farm").set(userDataMap);
  }
// chooseImage() async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//   setState(() {
//     _image.add(File(pickedFile!.path));
//   });
//   if (pickedFile!.path == null) retrieveLostData();
// }
//
// Future<void> retrieveLostData() async {
//   final LostData response = await picker.getLostData();
//   if (response.isEmpty) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       _image.add(File(response.file!.path));
//     });
//   } else {
//     print(response.file);
//   }
// }
}
