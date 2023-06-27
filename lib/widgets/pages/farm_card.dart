import 'package:afarms/models/addedFarm.dart';
import 'package:flutter/material.dart';

import '../../color_palette.dart';
import '../../models/farmdb.dart';
import 'farm_details_page.dart';

class FarmCard extends StatelessWidget {
  final addedFarm? Farm;
  final String? docID;

  const FarmCard({Key? key, this.Farm, this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FarmDetailsPage(
              docID: docID,
              farm: Farm,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 147,
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 6,
              color: const Color(0xff000000).withOpacity(0.06),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // SizedBox(
            //   height: 87,
            //   width: 87,
            //   child: (Product!.image == null)
            //       ? Center(
            //     child: Icon(
            //       Icons.image,
            //       color: ColorPalette.nileBlue.withOpacity(0.5),
            //     ),
            //   )
            //       : ClipRRect(
            //     borderRadius: BorderRadius.circular(11),
            //     child: CachedNetworkImage(
            //       fit: BoxFit.cover,
            //       imageUrl: Farm!.image!,
            //       errorWidget: (context, s, a) {
            //         return Icon(
            //           Icons.image,
            //           color: ColorPalette.nileBlue.withOpacity(0.5),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Farm!.name ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 30,
                      color: ColorPalette.timberGreen,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.location_on,
                  //       size: 14,
                  //       color: ColorPalette.timberGreen.withOpacity(0.44),
                  //     ),
                  //     Text(
                  //       Farm!.location ?? '-',
                  //       maxLines: 1,
                  //       style: const TextStyle(
                  //         fontFamily: "Nunito",
                  //         fontSize: 12,
                  //         color: ColorPalette.timberGreen,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.qr_code_sharp,
                          size: 14,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                        Text(
                          Farm!.farmcode ?? '-',
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 12,
                            color: ColorPalette.timberGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        Farm!.group ?? '-',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          top: 2,
                          right: 5,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                      Text(
                        Farm!.company ?? '-',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // width: 100,
                    child: Text(
                      Farm!.description ?? '-',
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 11,
                        color: ColorPalette.timberGreen.withOpacity(0.35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "GHC${Farm!.cost ?? '-'}",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 14,
                      color: ColorPalette.nileBlue,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${Farm!.quantity ?? '-'}\nAvailable",
                        style: const TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.nileBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
