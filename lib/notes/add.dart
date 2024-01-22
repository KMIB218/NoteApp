import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/components/crud.dart';
import 'package:my_project/components/customtextform.dart';
import 'package:my_project/components/valid.dart';
import 'package:my_project/constant/linkapi.dart';
import 'package:my_project/main.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({
    super.key,
  });

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  bool isloading = false;
  File? myfile;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formtext = GlobalKey<FormState>();
  Curd curd = Curd();
  addNote() async {
    if (myfile == null)
      return AwesomeDialog(
          context: context,
          title: "Error",
          body: Text("Please Choose Image For Your Note"))
        ..show();
    if (formtext.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await curd.postRequestWithFile(
          linkadd,
          {
            "title": title.text,
            "content": content.text,
            "userid": sharedpref.getString("id")
          },
          myfile!);
      isloading = false;
      setState(() {});
      if (response['s'] == 's') {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formtext,
                child: ListView(children: [
                  CustomText(
                    hint: "title",
                    cont: title,
                    valid: (val) {
                      return validInput(val!, 3, 1000);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    hint: "content",
                    cont: content,
                    valid: (val) {
                      return validInput(val!, 3, 1000);
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(
                      left: 70,
                      right: 70,
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          await addNote();
                        },
                        child: Text("Add Note")),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 70,
                      right: 70,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => Container(
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
                                    padding: EdgeInsets.all(10),
                                    child: Text("Choose Image From Gallery",
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
                                    padding: EdgeInsets.all(10),
                                    child: Text("Choose Image From Camera",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text("Add Image"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              myfile == null ? Colors.blue : Colors.red)),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
