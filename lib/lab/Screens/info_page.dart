import 'package:flutter/material.dart';

import '../../view/home_view.dart';


class dashboard extends StatefulWidget {
  final String userName;
  const dashboard({Key? key,required this.userName}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF800080),
        leading: const Icon(Icons.menu),
        title: const Text('DashBoard'),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.person_pin),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 100.0, 25.0, 25.0),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xff800080),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: Image.asset(
                      'assets/pic1.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      "Attendence",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 100.0, 25.0, 25.0),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xff800080),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                  ),
                  Positioned(
                    top: 70,
                    left: 25,
                    child: Image.asset(
                      'assets/pic2.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      " Quiz Marks",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xff800080),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Positioned(
                    top: -5,
                    left: 35,
                    child: Image.asset(
                      'assets/pic3.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      "Pharmacy Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xff800080),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                  ),
                  Positioned(
                    top: -20,
                    left: 10,
                    child: Image.asset(
                      'assets/pic4.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      "Home Work",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeView()),
  );
                    }),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
                      width: 120,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Color(0xff800080),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 35,
                    child: Image.asset(
                      'assets/pic6.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      "Pahrmacy Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
  //                    Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => const HomeView()),
  // );
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 25.0),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Color(0xff800080),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                    ),
                  ),
                  Positioned(
                    top: -5,
                    left: 20,
                    child: Image.asset(
                      'assets/pic7.png',
                      width: 100,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}