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
    final spaces = [
      Space(name: '客厅', icon: '🏠', itemCount: 120),
      Space(name: '厨房', icon: '🍳', itemCount: 45),
      Space(name: '卧室', icon: '🛏️', itemCount: 88),
      Space(name: '储物间', icon: '📦', itemCount: 210),
    ];

    for (final space in spaces) {
      final existing = await _isar!.spaces.where().nameEqualTo(space.name).findFirst();
      if (existing == null) {
        await _isar!.writeTxn(() async {
          await _isar!.spaces.put(space);
        });
      }
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
