import 'package:shared_preferences/shared_preferences.dart';

class Model {
  static SharedPreferences? pref;
  static List<String> imageLevel = [
    'p1.png',
    'p2.png',
    'p3.png',
    'p4.png',
    'p5.png',
    'p6.png',
    'p7.png',
    'p8.png',
    'p9.png',
    'p10.png'
  ];
  static List<String> answers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  static String clear = 'Clear';
  static String skip = 'Skip';
  static String pending = 'Pending';
  static String levelkey = 'levelkey';
}
