import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dabba_mart/confirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  int totalPrice = 0;
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculateTotalPrice();
  }
  
   void calculateTotalPrice() {
    totalPrice = 0;
    FirebaseFirestore.instance
        .collection("User Cart Item")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("product")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String priceString = doc['Price'];
        int price = int.tryParse(priceString) ?? 0;
        totalPrice += price;
      });
      setState(() {}); // Update the UI after calculating the total price
    }).catchError((error) {
      print("Error getting documents: $error");
    });
  }
  

  // ... rest of the code









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xfff25826),
        title: Text(
          "Your Cart Items",
          style: GoogleFonts.bebasNeue(color: Colors.black, fontSize: 30.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 10.h,
            width: 360.w,
            color: Colors.transparent,
          ),
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Cart Item")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("product")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Nothing add yet"),
                  );
                }
                if (!snapshot.hasData) return new Text('Loading...');
               
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      

                      
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 40.sp,
                              backgroundImage: NetworkImage(data["Image"]),
                            ),
                            title: Text(data["Name"]),
                            subtitle: Text(data['Price']),
                            trailing: InkWell(
                                onTap: () async {
                                  delet(snapshot.data!.docs[index].id);
                                },
                                child: Icon(Icons.delete))),
                      );
                    });
              },
            ),
          )),
          Container(
            height: 70.h,
            width: 360.w,
            child: Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}', // Format the price with 2 decimal places
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 70.h,
            width: 360.w,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
            child: Expanded(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Confirm()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                  fixedSize: MaterialStatePropertyAll(
                    Size(double.infinity, 70),
                  ),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.sp)))),
              child: Text(
                "Buy now",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            )),
          ),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }


void delet(id) {
  FirebaseFirestore.instance
      .collection("User Cart Item")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("product")
      .doc(id)
      .delete().then((value) => calculateTotalPrice());
}
}