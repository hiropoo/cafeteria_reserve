import 'package:sit_in_the_cafeteria/src/utils/env.dart';

class MyLocation {
  // 学食の座標
  static const Map<int, Map<String, double>> cafeLocations = {
    1: {'lat': 35.47254560684191, 'lng': 139.59318836868877}, // 第1食堂の座標
    2: {'lat': 35.47394872766653, 'lng': 139.5862287060324}, // 第2食堂の座標
  };

  // 学食を認識するための半径（メートル）
  static double radius = environment['locationRadius'] as double;
}
