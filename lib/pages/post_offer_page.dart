import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import '../components/take_picture.dart';
import '../global_var.dart' as globals;
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostOffer extends StatefulWidget {
  const PostOffer({Key? key}) : super(key: key);

  @override
  State<PostOffer> createState() => _PostOffer();
}

// this class builds the details of a certain offer
class _PostOffer extends State<PostOffer> {
  //Atributes
  //the controlers are useful to retrieve the tect from the text fields
  final myControllerName = TextEditingController();
  final myControllerDescription = TextEditingController();
  final myControllerDate = TextEditingController();
  DateTime? newDate;

  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";

  _PostOffer() {
    int size = globals.pathImages.length;
    if (size >= 1) image1 = globals.pathImages[0];
    if (size >= 2) image2 = globals.pathImages[1];
    if (size >= 3) image3 = globals.pathImages[2];
    if (size >= 4) image4 = globals.pathImages[3];
  }

  void postOffer(
      String title, String description, String image, String end_date) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/offers/'),
      body: jsonEncode(<String, String>{
        "category_id": "1",
        "title": title,
        "description": description,
        "image": image,
        "end_date": end_date
      }),
    );

    if (response.statusCode != 201) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            // Retrieve the text that the user has entered by using the
            // TextEditingController.
            content: const Text("Failed to get user offers."),
          );
        },
      );
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyOffers()));
    }
  }

  // This method gathers all the information and sends a request to the api with the info of the new offer.
  void validateOffer() {
    Map<String, dynamic> newOffer;
    try {
      //check if best before date is correct
      //todo: check if date is posterior to today

      DateFormat format = DateFormat("dd/MM/yyyy");

      DateTime now = DateTime.now();
      String todaydate = format.format(now);

      DateTime bestbefore = format.parseStrict(myControllerDate.text);

      if (bestbefore.isBefore(now)) throw Exception;

      newOffer = {
        "id": "1",
        "category_id": "1",
        "user_id": "1",
        "title": myControllerName.text,
        "description": myControllerDescription.text,
        "image": image1,
        "closed": false,
        "end_date": bestbefore.toString(),
        "created_at": todaydate.toString(),
        "closed_at": null
      };

      globals.pathImages.clear();

      postOffer(myControllerName.text, myControllerDescription.text, image1,
          bestbefore.toString());
    } catch (error) {
      print("error in format");
      _showErrorInDateFormat();
    }
  }

  // shows a dialog when the format in the date inserted is not correct
  Future<void> _showErrorInDateFormat() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //make alert rounded
          backgroundColor: const Color.fromARGB(237, 244, 242, 221),
          // Retrieve the text that the user has entered by using the
          // TextEditingController.
          content: const Text(
              "The entered date is not in the correct format or is before today"),
        );
      },
    );
  }

  // Builds the container of the picture. Its a button, so when clicked you can take a picture.
  Widget pictureButton() {
    return Container(
        height: 50,
        width: 70,
        decoration: BoxDecoration(
            color: const Color(0xFFCBD781),
            borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          icon: const Icon(
            Icons.camera_alt,
          ),
          onPressed: () async {
            WidgetsFlutterBinding.ensureInitialized();

            // Obtain a list of the available cameras on the device.
            final cameras = await availableCameras();

            // Get a specific camera from the list of available cameras.
            final firstCamera = cameras.first;

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                          camera: firstCamera,
                        )));
          },
        ));
  }

  // Returns the picture taken and displays it where the button to take a picture was
  Widget imageContainer(String imagePath) {
    return Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
          color: const Color(0xFFCBD781),
          borderRadius: BorderRadius.circular(10)),
      child: Image.file(File(imagePath)),
    );
  }

  // not used, but it displays a calendar to pick a date
  Future<void> datePicker() async {
    newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2020, 11, 17),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Post an offer',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 100, right: 100, bottom: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (image1 != "") imageContainer(image1) else pictureButton(),
                  if (image2 != "") imageContainer(image2) else pictureButton(),
                  if (image3 != "") imageContainer(image3) else pictureButton(),
                  if (image4 != "") imageContainer(image4) else pictureButton(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 30, right: 30),
                child: TextFormField(
                  controller: myControllerName,
                  key: const Key('nameOffer'),
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Name',
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
                padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                child: TextFormField(
                  controller: myControllerDate,
                  key: const Key('bestBefore'),
                  decoration: const InputDecoration(
                    labelText: 'Best before',
                    helperText: 'dd/mm/yyyy',
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
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 20, top: 40),
                child: TextFormField(
                  maxLines: 10,
                  minLines: 5,
                  controller: myControllerDescription,
                  key: const Key('description'),
                  maxLength: 256,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 42, 134, 0))),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
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
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFCBD781)),
                      foregroundColor:
                          MaterialStateProperty.all(const Color(0xFF2A8600))),
                  onPressed: () {
                    // Respond to button press
                    if (myControllerDescription.text == "" ||
                        myControllerName.text == "" ||
                        myControllerDate.text == "") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)), //make alert rounded
                            backgroundColor:
                                const Color.fromARGB(237, 244, 242, 221),
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            content: const Text(
                                "Please fill all the required fields"),
                          );
                        },
                      );
                    } else {
                      //todo: implement call to api
                      validateOffer();
                    }
                  },
                  child: const Text('Post offer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
