import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/my_offers.dart';
import 'take_picture.dart';
import 'global_var.dart' as globals;
import 'package:camera/camera.dart';

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

  // _PostOffer(
  //     [this.image1 = "", this.image2 = "", this.image3 = "", this.image4 = ""]);

  //TODO: create call to api
  void validateOffer() {}

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
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 20, top: 40),
                child: TextFormField(
                  maxLines: 10,
                  minLines: 5,
                  controller: myControllerDescription,
                  key: const Key('description'),
                  maxLength: 25,
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
                        myControllerName.text == "") {
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
                                "Input name and a description for the offer"),
                          );
                        },
                      );
                    } else {
                      //todo: implement call to api
                      validateOffer();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyOffers()));
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
