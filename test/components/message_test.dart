import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/components/message.dart';

void main() {
  testWidgets('create message from Map', (tester) async {
    Map<String, dynamic> data = {
      "id": "1",
      "imageOfOffer": "/static/hello.png",
      "imageOfSolicitor": "/static/johnson.png",
      "solicitorName": "Johnson",
      "offerId": "1"
    };
    Message message = Message.fromMap(data);

    expect(message.imageOfOffer, "/static/hello.png");
    expect(message.imageOfSolicitor, "/static/johnson.png");
    expect(message.solicitorName, "Johnson");
    expect(message.offerId, "1");
  });

  testWidgets('create message from default constructor', (tester) async {
    Message message = Message(
      id: "-1",
      imageOfOffer: "/static/hello.png",
      imageOfSolicitor: "/static/johnson.png",
      solicitorName: "Johnson",
      offerId: "1",
    );

    expect(message.imageOfOffer, "/static/hello.png");
    expect(message.imageOfSolicitor, "/static/johnson.png");
    expect(message.solicitorName, "Johnson");
    expect(message.offerId, "1");
    expect(message.id, "-1");
  });
}
