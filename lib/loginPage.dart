import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPage();
}

// this class builds the details of a certain offer
// ignore: camel_case_types
class _loginPage extends State<loginPage> {
  //Atributes
  Map<String, dynamic> userDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding:
                EdgeInsets.only(top: 120.0, left: 100, right: 100, bottom: 30),
            child: Image(
              image: AssetImage("images/appvocado-loading.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
            child: TextFormField(
              maxLength: 25,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 42, 134, 0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: TextFormField(
              maxLength: 25,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 42, 134, 0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), //rounded corners of the button
                  )),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFCBD781)),
                  foregroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 42, 134, 0))),
              onPressed: () {
                // Respond to button press
              },
              child: Text('Login'),
            ),
          )
        ],
      ),
    );
  }
}
