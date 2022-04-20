import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String image;

  UserModel({
    required this.name,
    required this.age,
    required this.image,
  });
}
