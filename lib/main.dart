
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circular.dart';






void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());}

class MyApp extends StatelessWidget {






  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(designSize: Size(375, 812),builder: (contex,index){
      return MaterialApp(debugShowCheckedModeBanner: false,title: "Nutretion app",theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: circular()
      );
    },);
  }
}
