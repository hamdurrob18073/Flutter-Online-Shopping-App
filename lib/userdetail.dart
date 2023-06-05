import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'frontpage.dart';



class userdata extends StatefulWidget {
  const userdata({Key? key}) : super(key: key);

  @override
  State<userdata> createState() => _userdataState();
}

class _userdataState extends State<userdata> {
  TextEditingController namecon = TextEditingController();
  TextEditingController phoneecon = TextEditingController();
  TextEditingController addcon = TextEditingController();
 
  
  User? userID = FirebaseAuth.instance.currentUser;

  senddata() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentuser = auth.currentUser;

    CollectionReference _collection =
        FirebaseFirestore.instance.collection("user data");
    return _collection
        .doc(currentuser!.email)
        .set({
          "name": namecon.text,
          "phone": phoneecon.text,
          "Adrress": addcon.text,
          
         
          "userID":userID?.uid,
        })
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => mainp())))
        .catchError(
            (error) => Fluttertoast.showToast(msg: "Something is wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffffffff),
            height: 800.h,
            width: 500.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  Container(
                    height: 140.h,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          "Give your information",
                          style: GoogleFonts.bebasNeue(fontSize:40.sp,color: Colors.black)
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Fill the from down",
                          style:
                              GoogleFonts.bebasNeue(fontSize:25.sp,color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 60.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffcfcfcf)),
                    child: TextField(style: TextStyle(color: Colors.black),
                      controller: namecon,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Your Name',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 60.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffcfcfcf)),
                    child: TextField(style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      controller: phoneecon,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintText: 'Phone number',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 60.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffcfcfcf)),
                    child: TextField(style: TextStyle(color: Colors.black),
                      controller: addcon,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                          hintText: ' Adrress',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  
                 
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 18),
                    child: GestureDetector(
                      child: Container(
                        height: 90.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xfff25826)),
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.black, fontSize: 25.sp),
                          ),
                        ),
                      ),
                      onTap: () {
                        senddata();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
