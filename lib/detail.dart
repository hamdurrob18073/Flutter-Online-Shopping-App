

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'confirm.dart';

class details extends StatefulWidget {
  var product;
  details(this.product);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  User? user =FirebaseAuth.instance.currentUser;
  Future usercart() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var Currentuser = _auth.currentUser;
    CollectionReference userCart =
        FirebaseFirestore.instance.collection("User Cart Item");
    return userCart.doc(Currentuser!.email).collection("product").doc().set({
      "Name": widget.product['name'],
      "Price": widget.product['price'],
      "Image": widget.product['img'],
      "Uid":user!.uid
      
     
    }).then((value) {
      Fluttertoast.showToast(msg: 'Product added to cart');
    });
  }
  Future WithOutCart() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var Currentuser = _auth.currentUser;
    CollectionReference userCart =
        FirebaseFirestore.instance.collection("Direct Buy");
    return userCart.doc(Currentuser!.email).collection("product").doc().set({
      "Name": widget.product['name'],
      "Price": widget.product['price'],
      "Image": widget.product['img'],
      "Uid":user!.uid
      
     
    });
  }

   

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffffffff),
          appBar: AppBar(
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Details Page"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
            ],
          ),
          body: Stack(alignment: Alignment.bottomCenter, children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    widget.product['img'],
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 45.h,
                                width: 400.w,
                                child: Row(
                                  children: [
                                    Text(
                                      widget.product['name'],
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xfff25826),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        widget.product["price"],
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                widget.product["des"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.sp),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {usercart();},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black),
                              fixedSize: MaterialStatePropertyAll(
                                Size(double.infinity, 70),
                              ),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.sp)))),
                          child: Text(
                            "Add To Cart",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        )),
                        SizedBox(width: 5.w,),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {WithOutCart().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>Confirm())));},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black),
                              fixedSize: MaterialStatePropertyAll(
                                Size(double.infinity, 70),
                              ),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.sp)))),
                          child: Text(
                            "Buy now",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
