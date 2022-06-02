import 'package:flutter_assignment2/components/offer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('offer created from json', (tester) async {
    final List<Map<String, dynamic>> myoffer = [
      {
        "id": "2",
        "category_id": "1",
        "user_id": "1",
        "title": "Half kg of lemons",
        "description": "Hello world!",
        "image":
            "https://post.healthline.com/wp-content/uploads/2020/09/lemon-health-benefits-1200x628-facebook-1200x628.jpg",
        "closed": false,
        "end_date": "23-03-2022",
        "created_at": "20-02-2022",
        "closed_at": "20-02-2022"
      }
    ];
    Offer offer = Offer.fromJson(myoffer[0]);
    expect(offer.id, "2");
    expect(offer.description, "Hello world!");
  });

  testWidgets('offer created', (tester) async {
    Offer offer = Offer(
        id: "1",
        categoryId: "1",
        userId: "1",
        title: "testTitle",
        description: "testDesc",
        image: "",
        closed: false,
        endDate: "20-02-2022",
        createdAt: "20-02-2022",
        closedAt: "25-02-2022");
    expect(offer.id, "1");
    expect(offer.description, "testDesc");
  });
}
