import 'package:flutter_assignment2/pages/offer_details_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  DotEnv().testLoad();
  // testWidgets('item is reserved', (tester) async {
  //   final List<Map<String, dynamic>> myoffer = [
  //     {
  //       "id": "2",
  //       "category_id": "1",
  //       "user_id": "1",
  //       "title": "Half kg of lemons",
  //       "description": "Hello world!",
  //       "image":
  //           "https://post.healthline.com/wp-content/uploads/2020/09/lemon-health-benefits-1200x628-facebook-1200x628.jpg",
  //       "closed": false,
  //       "end_date": "23-03-2022",
  //       "created_at": "20-02-2022",
  //       "closed_at": "20-02-2022"
  //     }
  //   ];
  //   await tester.pumpWidget(OfferDetails(myoffer[0]));
  //   var reserved = DotEnv().env['reserved'];
  //   if (reserved == "true") {
  //     expect(find.text('Cancel reservation'), findsOneWidget);
  //   }
  // });
}
