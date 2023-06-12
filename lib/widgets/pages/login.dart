import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../progressDialog.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();

  // text editing controllers
  final passwordController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                  const Text("Log in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA'),
                                    ),
                                    SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text("Jane Dow",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text("jane.doe@gmail.com",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18))
                                      ],
                                    )
                                  ]),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyTextField(
                                  controller: emailController,
                                  hintText: 'Password',
                                  obscureText: true,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyButtonAgree(
                                  text: "Continue",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                ),
                                const SizedBox(height: 30),
                                const Text('Forgot Password?',
                                    style: TextStyle(
                                        color:
                                        Color.fromARGB(255, 71, 233, 133),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.start),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging you ,Please wait.",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.toString().trim(),
      password: passwordController.text.toString().trim(),
    )
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      //
      // if (email.text == "merchantdaniel8@gmail.com") {
      //   Navigator.of(context).pushNamed("/admin");
      // } else

        if (firebaseUser != null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return homepage();
            }));
        displayToast("Logged-in ", context);
      } else {
        displayToast("Error: Cannot be signed in", context);
      }

      //final User? firebaseUser = userCredential.user;
      // if (firebaseUser != null) {
      //   final DatabaseEvent event = await
      //   //Admin.child(firebaseUser.uid).once();
      //   BoardMembers.child(firebaseUser.uid).once();
      //   // if (event.snapshot.value !=Admin) {
      //   //   Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen,
      //   //           (route) => false);
      //   //   displayToast("Logged-in As Admin", context);
      //   // }
      //   if(event.snapshot.value !=BoardMembers){
      //     Navigator.pushNamedAndRemoveUntil(context, VotersScreen.idScreen,
      //             (route) => false);
      //     displayToast("Logged-in As Board Member",
      //         context);
      //    // await _firebaseAuth.signOut();
      //   }

    } catch (e) {
      // handle error
    }
  }
}

