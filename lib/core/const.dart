import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user!.uid;

class Constants {
  static List<String> categoryList = [
    'Mobiles',
    'Laptops',
    'Clean',
    'Books',
    'Foods'
  ];
}
