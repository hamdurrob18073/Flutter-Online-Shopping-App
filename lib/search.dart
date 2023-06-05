import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'detail.dart';


class textfield extends StatefulWidget {
  const textfield({Key? key}) : super(key: key);

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  var product = [];
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 20,),


              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffcfcfcf)),
                child: TextFormField(style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(suffixIcon: Icon(Icons.search_outlined,color: Colors.black,),hintText: 'Search your product',hintStyle:TextStyle(color: Colors.black),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  onChanged: (val) {
                    setState(() {
                      inputText = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('product')
                        .where('name', isGreaterThanOrEqualTo: inputText)
                        .snapshots(),
                    builder: (
                      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot
                    ) {
                      if(snapshot.hasError){
                        return Center(child: Text("something is wrong"),);
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: Colors.black,),);
                      }

                      return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document) {


                        return GestureDetector(
                          child: Card(color: Color(0xffcfcfcf),
                            elevation: 2,
                            child: ListTile(
                              title: Text(document['name'],style: TextStyle(color: Colors.black),),
                              leading: Image.network(document['img']),
                            ),
                          ),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>details(document)));},
                        );
                      }).toList(),);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
