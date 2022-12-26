import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController imageUrlCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Medicine'),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                key: _formKey,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: priceCont,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffE2E5DE),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'price',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                                width: 1.0,
                              ),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: titleCont,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffE2E5DE),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'title',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                                width: 1.0,
                              ),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        maxLines: 4,
                        keyboardType: TextInputType.url,
                        controller: imageUrlCont,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffE2E5DE),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'image url',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                                width: 1.0,
                              ),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        maxLines: 5,
                        keyboardType: TextInputType.name,
                        controller: descCont,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffE2E5DE),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Description',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                                width: 1.0,
                              ),
                            ))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () async {
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection("medicines")
                          .doc();
                      await docRef.set({
                        'price': priceCont.text,
                        'id': docRef.id,
                        'title': titleCont.text,
                        'imageurl': imageUrlCont.text,
                        'description': descCont.text,
                        'is_medicine': true,
                        'is_disease': false,
                        'addedBy': FirebaseAuth.instance.currentUser!.uid,
                        'addedAt': Timestamp.now()
                      }).whenComplete(() async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Medicine added successfully"),
                          ),
                        );
                        priceCont.clear();
                        titleCont.clear();
                        imageUrlCont.clear();
                        descCont.clear();
                      });
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
