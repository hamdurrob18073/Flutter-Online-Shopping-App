import 'dart:async';

import 'package:dabba_mart/frontpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class anim extends StatefulWidget {
  const anim({super.key});

  @override
  State<anim> createState() => _animState();
}

class _animState extends State<anim> {
   startTimer(){
    Timer(Duration(seconds: 3), ()async {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>mainp()));
      
    });
  }
  @override
  void initState(){
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Container(child: Lottie.asset("image/1.json"),),
    );
  }
}