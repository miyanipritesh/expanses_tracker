import 'package:money_expance/utilies/constant.dart';

class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: AppIcon.home, name: 'Home'),
  Model(id: 1, imagePath: AppIcon.transation, name: 'Transaction'),
  Model(id: 2, imagePath: AppIcon.piaChart, name: 'Budget'),
  Model(id: 3, imagePath: AppIcon.user, name: 'Profile'),
];
