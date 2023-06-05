import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'glovel.dart';
import 'login.dart';

class Drower extends StatefulWidget {
  const Drower({Key? key}) : super(key: key);

  @override
  State<Drower> createState() => _DrowerState();
}

class _DrowerState extends State<Drower> {
  User? userID = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 812.h,
          width: 400.w,
          color: Colors.black,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  width: 400.w,
                  margin: EdgeInsets.only(top: 30, bottom: 5),
                  child: CircleAvatar(radius: 60.sp,backgroundColor: Color(0xfff25826),),
                ),
                Container(
                  height: 100.h,
                  width: 400.w,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("user data")
                        .where("userID", isEqualTo: userID?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }
                      return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        return Center(
                          child: ListTile(
                            title: Text(
                              document["name"],
                              style: TextStyle(
                                  fontSize: 22.sp, color: Colors.white),
                            ),
                            subtitle: Text(
                              firebaseAuth.currentUser!.email.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                          ),
                        );
                      }).toList());
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    "Setting",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    "About us",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      "log out",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpage())));
                  },
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.delete_sharp, color: Colors.red),
                    title: Text(
                      "Delete Account",
                      style: TextStyle(fontSize: 18.sp, color: Colors.red),
                    ),
                  ),
                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context){
                                                  return AlertDialog(
                                                    backgroundColor: Color(0xff31343b),
                                                    title: Text("Delete Account",style: TextStyle(color: Colors.white),),
                                                    content: Text("Your Acoount will delete",style: TextStyle(color: Colors.white)),
                                                    actions: <Widget>[
                                                       ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.blueGrey),onPressed: (){Navigator.pop(context);}, child: Text("No",style: TextStyle(color: Colors.white))),
                                                                ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.blueGrey),onPressed: (){firebaseAuth.currentUser!.delete().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpage())));}, child: Text("Yes",style: TextStyle(color: Colors.white))),
                                                    ],
                                                  );
                                                });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
