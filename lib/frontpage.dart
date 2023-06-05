import 'package:flutter/material.dart';

import 'botompage1.dart';
import 'bottompage2.dart';






class mainp extends StatefulWidget {
  @override
  State<mainp> createState() => _mainpState();
}

class _mainpState extends State<mainp> {
  var _correntindex = 0;
  final pages = [bp1(), bp2(), ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 20,unselectedFontSize: 10,backgroundColor: Colors.white,selectedItemColor: Colors.black,unselectedItemColor: Color.fromARGB(137, 17, 17, 17),
          currentIndex: _correntindex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  (Icons.home),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  (Icons.redeem),
                ),
                label: "Fashion"),
            
          ],
          onTap: (index) {
            setState(() {
              _correntindex = index;
            });
          },
        ),
        body: pages[_correntindex],
      ),
    );
  }
}
