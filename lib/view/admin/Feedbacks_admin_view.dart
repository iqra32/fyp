import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/feedback_model.dart';
import 'package:pharmacystore/utils/refs.dart';
import 'package:pharmacystore/view/models/user_model.dart';

class FeedbacksAdminView extends StatefulWidget {
  FeedbacksAdminView({
    Key? key,
  }) : super(key: key);

  @override
  _FeedbacksAdminViewState createState() => _FeedbacksAdminViewState();
}

class _FeedbacksAdminViewState extends State<FeedbacksAdminView> {
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
          'All Feedbacks',
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
                        'All Feedbacks below',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FBCollections.feedbacks.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> pharmacySnap) {
                        if (pharmacySnap.hasData) {
                          List<FeedbackModel> u = pharmacySnap.data!.docs
                              .map((e) => FeedbackModel.fromJson(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                          return ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(u.length, (index) {
                              FeedbackModel feedback = u[index];
                              DocumentReference dr =
                                  pharmacySnap.data!.docs[index].reference;
                              return FutureBuilder(
                                  future: feedback.userRef!.get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          userSnapshot) {
                                    if (!userSnapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    Users _user = Users.fromJson(
                                        userSnapshot.data!.data()
                                            as Map<String, dynamic>);
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          showBottomSheet(
                                              elevation: 100,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            _user.name
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text("Delete"),
                                                          onTap: () {
                                                            dr.delete();
                                                            Navigator.pop(
                                                                context);
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 8, 8, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 8, 4, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              _user.name,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                            SizedBox(
                                                              width: 32,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 16,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                            Text(
                                                              (feedback.rating ??
                                                                      5)
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 8, 0),
                                                          child: Text(
                                                            feedback.comment ??
                                                                "",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 4, 0, 0),
                                                      child: Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        color:
                                                            Color(0xFF57636C),
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
                                  });
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
