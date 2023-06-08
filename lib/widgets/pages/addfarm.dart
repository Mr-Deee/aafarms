import 'dart:io';
import 'dart:io' as io;
import 'package:afarms/models/addedFarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:path/path.dart' as Path;

import 'package:afarms/models/Users.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path/path.dart';

import '../../color_palette.dart';
import '../../main.dart';
import '../../toast.dart';
import '../progressDialog.dart';
class addfarm extends StatefulWidget {
  const addfarm({Key? key, this.group}) : super(key: key);
  final  String? group;
  @override
  State<addfarm> createState() => _addfarmState( group);
}


class _addfarmState extends State<addfarm> {






  List<File> _image = [];
  String? _selectedImage;
  String? group;
  _addfarmState(this.group);
  // final picker = ImagePicker();
  double val = 0;
  // final ImagePicker imagePicker = ImagePicker();
  bool uploading = false;
  final addedFarm newProduct = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  File? selectedfile;


  void _selectImage1(String image) {
    setState(() {
      _selectedImage = image;
      _selectedImage == selectedfile;
    });
  }




  final storage = FirebaseStorage.instance;
  final storageReference = FirebaseStorage.instance.ref();
  List<String> imagePaths = [

  ];
  String ?selectedImagePath;
  String ?uploadedImageUrl;
  @override
  Widget build(BuildContext context) {

    // var firstname = Provider
    //     .of<Users>(context)
    //     .userInfo
    //     ?.id!;
    var newprojectname=  newProduct.name;









    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor:  Color(0xff202020),
        backgroundColor: Color(0xffE99E22),
        title: Row(
          children: [
            const Text(
              "New Product",
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
          onPressed: () async{
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog(
                    message: "Adding New Product,Please wait.....",
                  );
                });
         //   String? url = await  uploadImage(selectedImagePath!);
            uploadsFile();
            //uploadImage(selectedImagePath!);
            Occupationdb();
            newProduct.group = group;
            _firestore
                .collection("products")
                .add({

              'image': url,
              'name': newProduct.name.toString(),
              'description': newProduct.description.toString(),
              'group': newProduct.group.toString(),
              'Company': newProduct.company.toString(),
              'Cost': newProduct.cost,
              'location': newProduct.location,
              'quantity': newProduct.quantity,
              //newProduct.toMap()
            })
                .then((value) {
              Navigator.of(context).pop();
              showTextToast('Added Sucessfully!');
            }).catchError((e) {
              if(url==null){
                showTextToast('No Image!');

              }
              showTextToast('Failed!');
            });
            // Navigator.of(context).pop();
          },
          splashColor: Colors.blue,
          backgroundColor: Color(0xffE99E22),
          child: const Icon(
            Icons.done,
            color:  Color.fromRGBO(216, 78, 16, 1),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          child: Container(
            color: Colors.blue,
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
                                height: 20,
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
                                                  left: 8, bottom: 12,),
                                                child: Text(
                                                  "Product Group : $group",
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 17,
                                                    color:Colors.blue,
                                                  ),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),



                                        DropdownButton<String>(
                                          value: selectedImagePath,
                                          onChanged: ( newValue) {
                                            setState(() {
                                              selectedImagePath = newValue;
                                            });
                                          },
                                          items: imagePaths.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),

                                        SizedBox(height: 34,),
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
                                            initialValue: newProduct.name ?? '',
                                            onChanged: (value) {
                                              newProduct.name = value;
                                            },
                                            textInputAction:
                                            TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color:Colors.blue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Product Name",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: Colors.blue,

                                              ),
                                            ),
                                            cursorColor:
                                            Colors.blue,
                                          ),
                                        ),
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
                                                    color:
                                                    Colors.blue,
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
                                                  cursorColor:
                                                  Colors.green,

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
                                                color: Colors.blue,

                                              ),
                                            ),
                                            cursorColor:
                                            Colors.blue,

                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:Colors.blue,

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
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                            ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 8,
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            "Location",
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 14,
                                              color: ColorPalette.nileBlue,
                                            ),
                                          ),
                                        ),
                                        //LocationDD(product: newProduct),



                                        // Container(
                                        //   padding: EdgeInsets.all(8), // Border width
                                        //   decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                        //   child: ClipOval(
                                        //     child: SizedBox.fromSize(
                                        //       size: Size.fromRadius(48), // Image radius
                                        //       child: Image.asset(_selectedImage??"assets/user.jpg", fit: BoxFit.cover),
                                        //     ),
                                        //   ),
                                        // ),





                                        // ListView(
                                        //   shrinkWrap: true,
                                        //   //crossAxisCount: 3,
                                        //   children: _images.map((image) {
                                        //     return GestureDetector(
                                        //       onTap: () => _selectImage1(image as String),
                                        //       child: Container(
                                        //         decoration: BoxDecoration(
                                        //           border: Border.all(
                                        //             color: _selectedImage == image ? Colors.blue : Colors.grey,
                                        //             width: 2,
                                        //           ),
                                        //         ),
                                        //         // child: Image.asset(image.toString()),
                                        //       ),
                                        //     );
                                        //   }).toList(),
                                        // ),
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
                                          borderRadius: BorderRadius.circular(11),

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

                                                  child:
                                                  CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    radius: 100,
                                                    backgroundImage: AssetImage(selectedImagePath!),

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

    final userId = currentfirebaseUser?.email;
    final _storage = FirebaseStorage.instance;

    String downloadUrl;

    //upload to firebase storage

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$group/${basename(image.path)}");

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
      'name': newProduct.name.toString(),
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
