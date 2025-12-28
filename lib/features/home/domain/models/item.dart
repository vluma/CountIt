import 'package:isar/isar.dart';

part 'item.g.dart'; // 稍后通过 build_runner 生成

@collection
class Item {
  Id id = Isar.autoIncrement; // 自增 ID

  @Index(type: IndexType.value)
  late String name; // 物品名称

  String? imageUrl; // 图片路径（本地或云端）

  String? category; // 分类

  @Index()
  String? location; // 位置（如：客厅-电视柜）

  int count = 1; // 数量

  DateTime? expiryDate; // 过期/保修时间

  DateTime createdAt = DateTime.now(); // 创建时间

  List<String>? tags; // 标签

  Item({
    required this.name,
    this.imageUrl,
    this.category,
    this.location,
    this.count = 1,
    this.expiryDate,
    this.tags,
  });
}
