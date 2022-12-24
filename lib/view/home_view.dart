import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/utils/search.dart';
import 'package:pharmacystore/view/app_drawer.dart';
import 'package:pharmacystore/view/notifications.dart';

import '../firebase_functions/getUser.dart';
import '../firebase_functions/readuser.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      AppUser.data = await getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsView()));
              },
              icon: Icon(Icons.notifications))
        ],
      ),
      body: Column(
        children: [
          // GetUserName(),

          SizedBox(
            height: 200,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbLSCOwsWy01tFkRjKc1GCNRAYmY9EZ06U7-9AxNak&s"),
                        fit: BoxFit.cover,
                      )),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      const Text(
                        "Explore and get effective \n results immediately",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      searchBar(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: MedicinesGrid()),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
            label: Text("Search"),
          ),
          onChanged: (v) {
            SearchController.searchText = v.toLowerCase();
            setState(() {});
          },
        ),
      ),
    );
  }
}
