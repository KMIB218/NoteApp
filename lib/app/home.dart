import 'package:flutter/material.dart';
import 'package:my_project/components/cardnote.dart';
import 'package:my_project/components/crud.dart';
import 'package:my_project/constant/linkapi.dart';
import 'package:my_project/main.dart';
import 'package:my_project/model/notemodel.dart';
import 'package:my_project/notes/add.dart';
import 'package:my_project/notes/edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Curd curd = Curd();

  viewNotes() async {
    var response = await curd.postRequest(linkview, {
      "userid": sharedpref.getString("id"),
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNotes(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await sharedpref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        title: Text("Home | ${sharedpref.getString("email")}"),
      ),
      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
              future: viewNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['s'] == 'f') {
                    return const Center(
                        child: Center(
                            child: Text(
                      "There Are No Notes",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardNote(
                        onDelete: () async {
                          var response = await curd.postRequest(linkdelete, {
                            "noteid": snapshot.data['data'][index]['notes_id']
                                .toString(),
                            "imagename": snapshot.data['data'][index]
                                    ['notes_image']
                                .toString(),
                          });

                          if (response['s'] == 's') {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "home", (route) => false);
                          }
                        },
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditNotes(note: snapshot.data['data'][index]),
                          ));
                        },
                        notemodel: Kemo.fromJson(snapshot.data['data'][index]),
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
