import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/utils/enums.dart';
import 'package:pharmacystore/utils/refs.dart';
import 'package:pharmacystore/view/models/user_model.dart';

class PharmaciesAdminView extends StatefulWidget {
  PharmaciesAdminView({
    Key? key,
  }) : super(key: key);

  @override
  _PharmaciesAdminViewState createState() => _PharmaciesAdminViewState();
}

class _PharmaciesAdminViewState extends State<PharmaciesAdminView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Color(0xB1592034),
        automaticallyImplyLeading: false,
        title: Text(
          'All Pharmacies',
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'All pharmacies below',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FBCollections.users
                          .where('role', isEqualTo: UserRole.pharmacist)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> pharmacySnap) {
                        if (pharmacySnap.hasData) {
                          List<Users> u = pharmacySnap.data!.docs
                              .map((e) => Users.fromJson(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                          return ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(u.length, (index) {
                              Users pharmacy = u[index];
                              DocumentReference dr =
                                  pharmacySnap.data!.docs[index].reference;
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: GestureDetector(
                                  onTap: () {
                                    void update(status) {
                                      dr.update({'status': status});
                                      Navigator.pop(context);
                                    }

                                    showBottomSheet(
                                        elevation: 100,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return Card(
                                            color: Colors.white,
                                            child: Container(
                                              height: 400,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      pharmacy.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  if (pharmacy.status ==
                                                      UserStatus.pending)
                                                    ListTile(
                                                      title: Text("Approve"),
                                                      onTap: () {
                                                        update(
                                                            UserStatus.active);
                                                      },
                                                    ),
                                                  if (pharmacy.status ==
                                                      UserStatus.active)
                                                    ListTile(
                                                      title: Text("Block"),
                                                      onTap: () {
                                                        update(
                                                            UserStatus.blocked);
                                                      },
                                                    ),
                                                  if (pharmacy.status ==
                                                      UserStatus.blocked)
                                                    ListTile(
                                                      title: Text("Unblock"),
                                                      onTap: () {
                                                        update(
                                                            UserStatus.active);
                                                      },
                                                    ),
                                                  ListTile(
                                                    title: Text("Delete"),
                                                    onTap: () {
                                                      dr.delete();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x411D2429),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 8, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 8, 4, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    pharmacy.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 8, 0),
                                                    child: Text(
                                                      pharmacy.status,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: Color(0xFF57636C),
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
