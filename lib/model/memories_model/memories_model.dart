
import 'package:hive_flutter/hive_flutter.dart';

part 'memories_model.g.dart';

@HiveType(typeId: 4)
class MemoriesModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<String?> images;
  @HiveField(2)
  String? mkey;
  @HiveField(3)
  String? mainImage;

  MemoriesModel({
    this.mkey,
    required this.title,
    required this.images,
    required this.mainImage
  });
}
