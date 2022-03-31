import 'package:flutter/material.dart';
import 'globalVar.dart' as globals;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Returns all the objects offered in a certain area formatted as cards
class Offer extends StatelessWidget {
  String title = "default";
  String best_before = "default";
  String distance = "default";
  List<String> offerDetails = [];
  //default image
  String image = "default";

  // constructor method
  Offer(List<String> offerDetails) {
    offerDetails = offerDetails;
    title = offerDetails.elementAt(3);
    best_before = offerDetails.elementAt(7);
    distance = "1.5 km"; // todo
    image = offerDetails.elementAt(5);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //todo
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ),
        // );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(image)),
            ListTile(
              title: Text(title,
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  )),
              subtitle: Text(distance + "       Best before: " + best_before,
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Offers near you',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[for (var i in globals.list) Offer(i)],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: IconButton(
                icon: Icon(Icons.travel_explore),
                onPressed: () {},
              )),
              Expanded(
                  child:
                      IconButton(icon: Icon(Icons.favorite), onPressed: () {})),
              Expanded(
                child: IconButton(
                    icon: Icon(Icons.shopping_cart_outlined), onPressed: () {}),
              ),
              Expanded(
                  child: IconButton(icon: Icon(Icons.mail), onPressed: () {})),
              Expanded(
                  child:
                      IconButton(icon: Icon(Icons.person), onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
