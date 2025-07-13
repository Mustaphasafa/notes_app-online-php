import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/Facilities/cardnote.dart';
import 'package:fluttercourse/Models/notesmodel.dart';
import 'package:fluttercourse/auth/crud.dart';
import 'package:fluttercourse/auth/linkapi.dart';
import 'package:fluttercourse/auth/login.dart';
import 'package:fluttercourse/main.dart';
import 'package:fluttercourse/notes/add.dart';
import 'package:fluttercourse/notes/edit.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with GetPost {
  viewNotes() async {
    var response =
        await postRequest(linkView, {"id": sharedPref.getString("id")});
    if (response['data'].length != null) {
      return response;
    } else {
      return response['data'].length = 0;
    }
  }

  deleteNote(noteid,imagename) async {
    var response = await postRequest(linkDelete, {"noteid": noteid,"file":imagename});
    if (response['status'] == "succes") {
      Get.offAll(() => Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[300],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Get.to(() => AddNote());
          }),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Get.offAll(() => Login());
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text("HomePage"),
      ),
      body: Container(
        color: Colors.blueGrey[100],
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            FutureBuilder(
                future: viewNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, i) {
                          return Cardnote(
                            longPress: () {
                              AwesomeDialog(
                                context: context,
                                title: 'Warning',
                                btnCancelOnPress: () {
                                  Get.back();
                                },
                                body: Text("Are You Sure To Delete?"),
                                btnOkOnPress: () async {
                                  await deleteNote(snapshot.data['data'][i]
                                          ['notes_id']
                                      .toString(),snapshot.data['data'][i]["notes_image"]);
                                },
                              )..show();
                            },
                            tap: () {
                              Get.to(() => EditNote(
                                imagename: snapshot.data["data"][i]
                                        ["notes_image"],
                                    noteid: snapshot.data["data"][i]["notes_id"]
                                        .toString(),
                                    Title: snapshot.data["data"][i]
                                        ["notes_title"],
                                    content: snapshot.data["data"][i]
                                        ["notes_content"],
                                  ));
                            },
                            notemodel:
                                NoteModel.fromJson(snapshot.data["data"][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading ..."));
                  }
                  return Center(
                      child: Text(
                    "There is no note.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ));
                })
          ],
        ),
      ),
    );
  }
}
