import 'package:flutter/material.dart';
import 'package:my_project/components/crud.dart';
import 'package:my_project/components/customtextform.dart';
import 'package:my_project/components/valid.dart';
import 'package:my_project/constant/linkapi.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  singup() async {
    if (formtext.currentState!.validate()) {
      islodaing = true;
      setState(() {});
      var response = await _curd.postRequest(linksingup, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });

      islodaing = false;
      setState(() {});
      if (response["s"] == "s") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("========================================");
        print("Sing Up Failed");
        print("========================================");
      }
    }
  }

  final Curd _curd = Curd();

  bool islodaing = false;
  GlobalKey<FormState> formtext = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
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
                        cont: username,
                        hint: "Username",
                        valid: (val) {
                          return validInput(val!, 5, 20);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                          valid: (val) {
                            return validInput(val!, 3, 50);
                          },
                          cont: email,
                          hint: "E-Mail"),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                          valid: (val) {
                            return validInput(val!, 2, 50);
                          },
                          cont: password,
                          hint: "Password"),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          onPressed: () async {
                            await singup();
                          },
                          child: const Text("Sing Up")),
                      Row(
                        children: [
                          const Text("If You Already Have Account"),
                          const SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/");
                            },
                            child: const Text(
                              "Clich Here",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
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
