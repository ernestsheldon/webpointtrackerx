import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PointViewList extends StatefulWidget {
  const PointViewList({Key? key}) : super(key: key);

  @override
  _PointViewListState createState() => _PointViewListState();
}

class _PointViewListState extends State<PointViewList> {
  TextEditingController _pointDate = TextEditingController();
  TextEditingController _pointValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pointDate.text = "";
    _pointValue.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('points')
                .orderBy('pointdate')
                .get(),
            builder: (_, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: documents.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, int index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                      final snackBar =   SnackBar(
                                          content: const Text('point deleted'));
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        
                                        //print(documents[index].data());
                                        FirebaseFirestore.instance
                                            .collection('points')
                                            .doc(documents[index].id)
                                            .delete();
                                      });
                                     
                                    },
                                    onTap: () {
                                      //add update dialog
                                      setState(() {
                                        print("update pressed");

                                        _pointDate.text =
                                            documents[index].get('pointdate');
                                        _pointValue.text =
                                            documents[index].get('pointvalue');
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      TextField(
                                                          controller: _pointDate,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText: documents[
                                                                          index]
                                                                      .get(
                                                                          'pointdate'),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                25.0),
                                                                  ))),
                                                      TextField(
                                                          controller: _pointValue,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText: documents[
                                                                          index]
                                                                      .get(
                                                                          'pointvalue'),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                25.0),
                                                                  ))),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'points')
                                                                .doc(documents[
                                                                        index]
                                                                    .id)
                                                                .update({
                                                              "pointdate":
                                                                  _pointDate.text,
                                                              "pointvalue":
                                                                  _pointValue
                                                                      .text,
                                                            });
                                                          });
                                                          final snackBar =   SnackBar(
                                          content: const Text('point updated'));
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("update"),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      });
                                    },
                                    child:
                                        Text("Point Date: " + documents[index].get('pointdate'),
                                        style: TextStyle(fontSize: 18),)),
                                SizedBox(width: 10),
                                Text("Point value: " + documents[index].get('pointvalue'),
                                style: TextStyle(fontSize: 18),),

                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
