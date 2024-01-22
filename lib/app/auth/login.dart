import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:my_project/components/crud.dart';
import 'package:my_project/components/customtextform.dart';
import 'package:my_project/components/valid.dart';
import 'package:my_project/constant/linkapi.dart';
import 'package:my_project/main.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formtext = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Curd curd = Curd();

  bool islodaing = false;

  login() async {
    islodaing = true;
    setState(() {});
    if (formtext.currentState!.validate()) {
      var response = await curd.postRequest(linklogin, {
        "email": email.text,
        "password": password.text,
      });
      islodaing = false;
      setState(() {});
      if (response["s"] == "s") {
        sharedpref.setString("id", response['data']['id'].toString());
        sharedpref.setString("email", response['data']['email']);
        sharedpref.setString("password", response['data']['password']);

        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        return AwesomeDialog(
            title: "Error",
            btnCancel: const Text("Cancel"),
            body: const Text("Wrong Password Or E-Mail"),
            animType: AnimType.scale,
            context: context)
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: islodaing == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(children: [
                Form(
                  key: formtext,
                  child: Column(
                    children: [
                      Image.asset("images/1.jpg"),
                      CustomText(
                          valid: (val) {
                            return validInput(val!, 5, 50);
                          },
                          cont: email,
                          hint: "E-Mail"),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                          valid: (val) {
                            return validInput(val!, 5, 50);
                          },
                          cont: password,
                          hint: "Password"),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          onPressed: () async {
                            await login();
                          },
                          child: const Text("LogIn")),
                      Row(
                        children: [
                          const Text("If You Don't Have Account"),
                          const SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("singup");
                            },
                            child: const Text(
                              "Clich Here",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
