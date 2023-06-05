import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'animation.dart';

class Confirm extends StatefulWidget {
 
 



  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  List<String> payment = ["Bkash", "Nogod", "Cash on Delivery"];
  List<String> zone =["Varthokhola","KhujarKhola","Amberkhana","Bondor","ZindaBazar","Subidbazar","MiraBazar"];
  
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _zone = TextEditingController();
  TextEditingController _pament = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  var isFinished = false;
  confirmdata() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentuser = auth.currentUser;
    CollectionReference _collection =
        FirebaseFirestore.instance.collection("Confirm order").doc(currentuser!.email).collection("Final");
    return _collection
        .doc()
        .set({
          "Name": _name.text,
          "Phone": _phone.text,
          "Address": _address.text,
          "Zone": _zone.text,
          "Payment": _pament.text,
          "UserID":user?.uid,
         
        }).then((value) =>  Navigator.push(context,MaterialPageRoute(builder: (context)=>anim(),
                            )
                          ));
       
  }
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Confirm your Product",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "Give your correct imformation",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      height: 60.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffcfcfcf)),
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: _name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.drive_file_rename_outline),prefixIconColor: Colors.black,
                            hintText: 'Your name',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffcfcfcf)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: _phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),prefixIconColor: Colors.black,
                            hintText: 'Your phone Number',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffcfcfcf)),
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: _address,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home),prefixIconColor: Colors.black,
                            hintText: 'Your address',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffcfcfcf)),
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: _zone,
                         decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),prefixIconColor: Colors.black,
                            suffixIcon: DropdownButton<String>(
                              items: zone.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _zone.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {
                               
                             },
                            ),
                            hintText: 'Select Your Zone ',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffcfcfcf)),
                      child: TextField(

                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: _pament,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.payment),prefixIconColor: Colors.black,
                            suffixIcon: DropdownButton<String>(
                              items: payment.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _pament.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {
                                if (_pament.text == payment[0]) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "This System is currently not available");
                                } else if (_pament.text == payment[1]) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "This System is currently not available");
                                }
                                else(Fluttertoast.showToast(msg: "This system is available"));
                              },
                            ),
                            hintText: 'Payment method',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 25),
                      child: SwipeableButtonView(
                        buttonText: "SLIDE TO PAYMENT",
                         buttonWidget: Container(
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                    ),
                                    
                                    ),activeColor: Color(0xfff25826),
                                    isFinished:isFinished,
                                     onWaitingProcess: () {
                        Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                    isFinished = true;
                        });
                      });
                      
                                      },
                                      onFinish: () async {
                            await confirmdata();
                    
                      
                      setState(() {
                        isFinished = false;
                      });
                                      },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
