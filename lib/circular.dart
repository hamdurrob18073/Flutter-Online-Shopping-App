import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dabba_mart/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import 'frontpage.dart';
import 'glovel.dart';






class circular extends StatefulWidget {
  const circular({Key? key}) : super(key: key);

  @override
  State<circular> createState() => _circularState();
}

class _circularState extends State<circular> {
  
  Future checkConnection()async{
    var connectivityResult = await(Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.none){
      Fluttertoast.showToast(msg: "No internet connection");
    }
    else(
    Timer(Duration(seconds: 3), ()async {
      if(firebaseAuth.currentUser!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> mainp()));
      }
      else{Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> splash()));}
    }));
  
    
  }
 
  @override
  void initState(){
    super.initState();
    checkConnection();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Color(0xffffffff),body:  Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
       Lottie.asset("image/2.json"),
       Text("Dabba-Mart",style: TextStyle(color: Color(0xfff25826),fontSize: 35.sp,fontWeight: FontWeight.bold),)
    ],));
  }
}
