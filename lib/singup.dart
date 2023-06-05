
import 'package:dabba_mart/userdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'glovel.dart';
import 'login.dart';



class rejister extends StatefulWidget {
  const rejister({Key? key}) : super(key: key);

  @override
  State<rejister> createState() => _rejisterState();
}

class _rejisterState extends State<rejister> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool obscureText = true;
  singup()async{

    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: namecontroller.text,
          password: passcontroller.text
      );
      var authCredential = userCredential.user;
      if(authCredential!.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>userdata()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);


    }
     sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences!.setString("email",namecontroller.text);
    await sharedPreferences!.setString("password", passcontroller.text);

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          child: Container(
           
            height: 800.h,
            width: 400.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 350.h,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create An Account",
                          style: TextStyle(color: Colors.black,fontSize: 40.sp,fontWeight: FontWeight.bold)
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Wellcome to the world of Dabba_Mart",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 65.h,
                    width: 350.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color(0xffcfcfcf)),
                    child: TextField(style: TextStyle(color: Colors.black,fontSize: 18),
                      controller: namecontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),hintText: "Enter your Email", hintStyle:
                      TextStyle(color: Colors.black, fontSize: 15),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 65.h,
                    width: 350.w,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color(0xffcfcfcf)),
                    child: TextField(style: TextStyle(color: Colors.black,fontSize: 18),
                      obscureText: obscureText,
                      controller: passcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: obscureText ==true?
                          IconButton(onPressed: (){setState(() {
                            obscureText =false;

                          });}, icon: Icon(Icons.remove_red_eye,size: 20.w,color: Colors.black,)):
                          IconButton(onPressed: (){setState(() {
                            obscureText = true;
                          });}, icon:Icon(Icons.visibility_off,size: 20.w,color: Colors.black) ),

                          hintText: 'Enter your password',
                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 80),
                  child: GestureDetector(
                    child: Container(
                      height: 90.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          color: Color(0xfff25826),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.black, fontSize: 28),
                        ),
                      ),
                    ),
                    onTap: () {singup();
                    },
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  height: 30.h,
                  width: 400.w,
                  child: Row(
                    children: [
                      Container(
                        height: 30.h,
                        width: 230.w,
                        padding: EdgeInsets.only(left: 70, top: 2),
                        child: Text(
                          "Already have an Account?",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),

                      GestureDetector(
                        child: Container(
                          height: 30.h,
                          width: 80.w,
                          child: Text(
                            "Sing in",
                            style: TextStyle(color: Color(0xfff25826), fontSize: 18),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginpage()));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}