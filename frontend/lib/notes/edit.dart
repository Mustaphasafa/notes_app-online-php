import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercourse/Facilities/textformfield.dart';
import 'package:fluttercourse/auth/crud.dart';
import 'package:fluttercourse/auth/linkapi.dart';
import 'package:fluttercourse/home.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditNote extends StatefulWidget {
  final noteid;
  final Title;
  final content;
  final imagename;

  const EditNote(
      {super.key, this.noteid, this.Title, this.content, this.imagename});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with GetPost {
  File? myfile;

  GlobalKey<FormState> form = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController Content = TextEditingController();

  editNote() async {
    var response;
    if (myfile == null) {
      response = await postRequest(linkEdit, {
        "noteid": widget.noteid,
        "title": title.text,
        "content": Content.text,
          "imagename": widget.imagename,
      });
      if (response['status'] == "succes") {
        Get.offAll(() => Home());
      }
    } else {
      response = await postRequestWithFile(
          linkEdit,
          {
            "imagename": widget.imagename,
            "noteid": widget.noteid,
            "title": title.text,
            "content": Content.text
          },
          myfile!);
      if (response['status'] == "succes") {
        Get.offAll(() => Home());
      }
    }
  }

  @override
  void initState() {
    title.text = widget.Title;
    Content.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Center(
        child: Form(
            key: form,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                CustomTextField(
                  texthint: "title",
                  controller: title,
                ),
                CustomTextField(
                  texthint: "content",
                  controller: Content,
                ),
                MaterialButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              alignment: Alignment.centerLeft,
                              height: 100,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      "Choose an image",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () async {
                                          XFile? file = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          if (file != null) {
                                            myfile = File(file.path);
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          "from camera",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () async {
                                          XFile? file = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();

                                          if (file != null) {}
                                          myfile = File(file!.path);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "from galary",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  color:
                      myfile == null ? Colors.orangeAccent[100] : Colors.green,
                  textColor: Colors.white,
                  child: myfile == null ? Text("Choose Image") : Text("change"),
                ),
                MaterialButton(
                  onPressed: () async {
                    await editNote();
                  },
                  child: Text("Edit"),
                )
              ],
            )),
      ),
    );
  }
}
