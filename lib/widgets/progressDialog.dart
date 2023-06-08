import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {

  String message;
  ProgressDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6.0)
        ),
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
scrollDirection: Axis.horizontal,
        child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white38),),
              SizedBox(width: 26.0,),
              Text(
                message,
                style: TextStyle(color: Colors.white38, fontSize: 10.0),

              ),

            ],
        ),
      ),
    ),



      ),
    );
  }
}
