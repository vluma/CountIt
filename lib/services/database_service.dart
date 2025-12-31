import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../features/home/domain/models/item.dart';
import '../features/home/domain/models/space.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Isar? _isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ItemSchema, SpaceSchema],
      directory: dir.path,
      name: 'countit_db',
    );

    // 初始化默认空间
    await _initializeDefaultSpaces();
  }

  Future<void> _initializeDefaultSpaces() async {
    // 批量检查现有空间，减少数据库查询次数
    final existingSpaces = await _isar!.spaces.where().findAll();
    final existingNames = existingSpaces.map((s) => s.name).toSet();

    final spacesToAdd = [
      Space(name: '客厅', icon: '🏠', itemCount: 120),
      Space(name: '厨房', icon: '🍳', itemCount: 45),
      Space(name: '卧室', icon: '🛏️', itemCount: 88),
      Space(name: '储物间', icon: '📦', itemCount: 210),
    ].where((space) => !existingNames.contains(space.name)).toList();

    // 批量写入，减少事务次数
    if (spacesToAdd.isNotEmpty) {
      await _isar!.writeTxn(() async {
        for (final space in spacesToAdd) {
          await _isar!.spaces.put(space);
        }
      });
    }
  }

  Isar get isar {
    if (_isar == null) {
      throw Exception('Database not initialized');
    }
    return _isar!;
  }

  Future<List<Item>> getItems() async {
    return await isar.items.where().findAll();
  }

  Future<List<Space>> getSpaces() async {
    return await isar.spaces.where().findAll();
  }

  Future<void> addItem(Item item) async {
    await isar.writeTxn(() async {
      await isar.items.put(item);
    });
  }

  Future<void> updateItem(Item item) async {
    await isar.writeTxn(() async {
      await isar.items.put(item);
    });
  }

  Future<void> deleteItem(int id) async {
    await isar.writeTxn(() async {
      await isar.items.delete(id);
    });
  }
}
