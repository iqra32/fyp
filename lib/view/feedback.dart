import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pharmacystore/model/feedback_model.dart';
import 'package:pharmacystore/utils/refs.dart';
import 'package:pharmacystore/widgets/button.dart';

class GetFeedbackView extends StatefulWidget {
  const GetFeedbackView({Key? key}) : super(key: key);

  @override
  _GetFeedbackViewState createState() => _GetFeedbackViewState();
}

class _GetFeedbackViewState extends State<GetFeedbackView> {
  TextEditingController? textController;
  double? ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xB1592034),
        automaticallyImplyLeading: true,
        title: const Text(
          'Feedback',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFF8F8F8),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                child: Text(
                  'How likely would you recommend this App?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              RatingBar.builder(
                onRatingUpdate: (newValue) =>
                    setState(() => ratingBarValue = newValue),
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                direction: Axis.horizontal,
                initialRating: ratingBarValue ??= 3,
                unratedColor: Color(0xFF9E9E9E),
                itemCount: 5,
                itemSize: 40,
                glowColor: Colors.yellow,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: textController,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white54,
                  ),
                  // style: FlutterFlowTheme.of(context).bodyText1,
                  maxLines: 10,
                  minLines: 6,
                ),
              ),
              MyButtonWidget(
                onPressed: () async {
                  try {
                    if (ratingBarValue == null) return;
                    if (textController == null) return;
                    if (textController!.text.isEmpty) return;
                    FeedbackModel fm = FeedbackModel(
                        rating: ratingBarValue!.toInt(),
                        comment: textController!.text,
                        reviewedAt: Timestamp.now(),
                        userRef: FBCollections.users
                            .doc(FirebaseAuth.instance.currentUser!.uid));
                    await FBCollections.feedbacks.add(fm.toJson());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thanks for your feedback.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: Colors.black54,
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                  }
                },
                text: 'Submit',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: Theme.of(context).primaryColor,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
