import 'package:isar/isar.dart';

part 'space.g.dart';

@collection
class Space {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name; // 空间名称

  String? parentPath; // 父路径，用于嵌套空间

  String? icon; // 空间图标

  int itemCount = 0; // 物品数量

  DateTime createdAt = DateTime.now();

  Space({
    required this.name,
    this.parentPath,
    this.icon,
    this.itemCount = 0,
  });
}
