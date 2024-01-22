import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/components/crud.dart';
import 'package:my_project/components/customtextform.dart';
import 'package:my_project/constant/linkapi.dart';
import 'package:image_picker/image_picker.dart';

class EditNotes extends StatefulWidget {
  final note;
  const EditNotes({
    super.key,
    required this.note,
  });

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  bool isloading = false;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formtext = GlobalKey<FormState>();
  File? myfile;
  Curd curd = Curd();
  editNote() async {
    if (formtext.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await curd.postRequest(linkedit, {
          "title": title.text,
          "content": content.text,
          "noteid": widget.note['notes_id'].toString(),
          "imagename": widget.note['notes_image'].toString()
        });
      } else {
        response = await curd.postRequestWithFile(
            linkedit,
            {
              "title": title.text,
              "content": content.text,
              "noteid": widget.note['notes_id'].toString(),
              "imagename": widget.note['notes_image'].toString()
            },
            myfile!);
      }
      isloading = false;
      setState(() {});
      if (response['s'] == 's') {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }
    }
  }

  @override
  void initState() {
    title.text = widget.note['notes_title'];
    content.text = widget.note['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formtext,
                child: ListView(children: [
                  CustomText(
                    hint: "title",
                    cont: title,
                    valid: (val) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    hint: "content",
                    cont: content,
                    valid: (val) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 70,
                      right: 70,
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          await editNote();
                        },
                        child: const Text("Edit Note")),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.of(context).pop();
                                  myfile = File(xfile!.path);
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child: const Text("Choose Image From Gallery",
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.of(context).pop();
                                  myfile = File(xfile!.path);
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child: const Text("Choose Image From Camera",
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            myfile == null ? Colors.blue : Colors.red)),
                    child: const Text("Add Image"),
                  ),
                ]),
              ),
            ),
    );
  }
}
