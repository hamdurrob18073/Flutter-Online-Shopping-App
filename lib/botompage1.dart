import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dabba_mart/search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cartpage.dart';
import 'detail.dart';
import 'drower.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:badges/badges.dart' as badges;




class bp1 extends StatefulWidget {
  const bp1({Key? key}) : super(key: key);

  @override
  State<bp1> createState() => _bp1State();
}

class _bp1State extends State<bp1> {
  List product = [];
  FirebaseAuth _auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Drower(),),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xfff25826)),
        title: Text("Dabba-Mart",style: GoogleFonts.bebasNeue(fontSize: 40.sp,color: Color(0xfff25826)),),centerTitle: true,
        

       actions: <Widget>[
      StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance
                  .collection("User Cart Item")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("product")
                  .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                  },
                  icon: Icon(Icons.shopping_cart, color: Color(0xfff25826)),
                );
              } else {
                int itemCount = snapshot.data?.docs.length ?? 0;
                return badges.Badge(
                   position: badges.BadgePosition.topEnd(top: 0,end: 3),
                  badgeContent: Text(
                    itemCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                    },
                    icon: Icon(Icons.shopping_cart, color: Color(0xfff25826)),
                  ),
                );
              }
            },
          ),
        
       
       ],
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        

      ),
      body:
         SingleChildScrollView(
           child: Container(
             color: Color( 0xffffffff),
            height: 650.h,
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                                height: 55.h,
                                width: 330.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffcfcfcf),),
                                    
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search,color: Colors.black,),
                                    hintText: 'search here....',
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => textfield()));
                                    
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                                child: Container(
                                  height: 130,width: 330,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20),image: DecorationImage(image: AssetImage("image/daba.jpg"),fit: BoxFit.cover)),
                                ),
                              ),
                              ListTile(
                                leading: Text("Best Selling",style: TextStyle(fontSize: 25,color: Color(0xfff25826)),), 
                                
                              ),
                              Container(height: 325.h,width: 350.w,child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('product')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData)
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              );
                                               return GridView(
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    mainAxisExtent: 180),
                                                children: snapshot.data!.docs
                                                    .map((DocumentSnapshot document) {
                                                  return GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>details(document)));},
                                                    child: Card(elevation: 3,
                                                      child: GridTile(
                                                          child: Container(
                                                          
                                                             
                                                              color: Color(0xffffffff),
                                                            
                                                           
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 150.h,
                                                                  width: 330.w,
                                                                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(document['img']),fit: BoxFit.cover),
                                                                      ),
                                                             
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 8,right: 4),
                                                                  child: Container(
                                                                   
                                                                    height: 68.h,
                                                                    width: 330.w,
                                                                    child:Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                          height: 30.h,
                                                                          width: 200.w,
                                                                          child: Text(document['name'],style: TextStyle(fontSize: 25.sp,color: Colors.black),),
                                                                        ),
                                                                        SizedBox(height: 5.h,),
                                                                        Container(
                                                                          height: 30.h,
                                                                          width: 200.w,
                                                                          child: Text(document["price"],style: TextStyle(fontSize: 18.sp,color: Colors.black),),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                                }).toList());
                                          }),
                                              
                                              
                                              
                                              
                                              
                                              
                                              
         
                
               
            )],
            ),
                 ),
         ),

    );
  }
}
