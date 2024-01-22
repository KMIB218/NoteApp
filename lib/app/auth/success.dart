import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You Singed Up Successfully You Can Log in"),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                child: const Text("Log In")),
          ],
        ),
      ),
    ));
  }
}
