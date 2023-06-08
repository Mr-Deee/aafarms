import 'package:afarms/models/addedFarm.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../color_palette.dart';
import 'homepages.dart';


class FarmDetailsPage extends StatelessWidget {
  final addedFarm? farm;
  final String? docID;
FarmDetailsPage({Key? key, this.farm, this.docID}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            _firestore
                .collection("products")
                .doc(docID)
                .update(farm!.toMap())
                .then((value) {
              displayToast('Updated Sucessfully!',context);
            }).catchError((e) {
              displayToast('Failed!',context);
            });
            Navigator.of(context).pop();
          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: ColorPalette.pacificBlue,
          child: const Icon(
            Icons.done,
            color: ColorPalette.white,
          ),
        ),
      ),
      body: Container(
        color: ColorPalette.pacificBlue,
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
                    color: ColorPalette.pacificBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Text(
                            "Edit Product",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              color: ColorPalette.timberGreen,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: ColorPalette.timberGreen,
                        ),
                        onPressed: () {
                          _firestore
                              .collection("products")
                              .doc(docID)
                              .delete()
                              .then((value) {
                            displayToast('Deleted Sucessfully!',context);
                          }).catchError((e) {
                            displayToast('Failed!',context);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
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
                                    color: ColorPalette.white,
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
                                          child: Text(
                                            "Product Group : ${farm!.group}",
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              color: ColorPalette.nileBlue,
                                            ),
                                          ),
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
                                            initialValue: farm!.name ?? '',
                                            onChanged: (value) {
                                              farm!.name = value;
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
                                              hintText: "Product Name",
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
                                                  initialValue: farm!.cost ==
                                                      null
                                                      ? ''
                                                      : farm!.cost.toString(),
                                                  onChanged: (value) {
                                                    farm!.cost =
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
                                                  ColorPalette.timberGreen,
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
                                                  farm!.quantity == null
                                                      ? ''
                                                      : farm!.quantity
                                                      .toString(),
                                                  onChanged: (value) {
                                                    farm!.quantity =
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
                                            initialValue: farm!.company ?? '',
                                            onChanged: (value) {
                                              farm!.company = value;
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
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                            ColorPalette.timberGreen,
                                          ),
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
                                            farm!.description ?? '',
                                            onChanged: (value) {
                                              farm!.description = value;
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
                                        //  LocationDD(product: product),
                                      ],
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.topCenter,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(top: 10),
                                //     child: SizedBox(
                                //       height: 100,
                                //       width: 100,
                                //       child: ClipRRect(
                                //         borderRadius: BorderRadius.circular(11),
                                //         child: Container(
                                //           color: ColorPalette.white,
                                //           child: Container(
                                //             color: ColorPalette.timberGreen
                                //                 .withOpacity(0.1),
                                //             child: (product!.image == null)
                                //                 ? Center(
                                //               child: Icon(
                                //                 Icons.image,
                                //                 color: ColorPalette
                                //                     .nileBlue
                                //                     .withOpacity(0.5),
                                //               ),
                                //             )
                                //                 : CachedNetworkImage(
                                //               fit: BoxFit.cover,
                                //               imageUrl: product!.image!,
                                //               errorWidget:
                                //                   (context, s, a) {
                                //                 return Icon(
                                //                   Icons.image,
                                //                   color: ColorPalette
                                //                       .nileBlue
                                //                       .withOpacity(0.5),
                                //                 );
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
}
