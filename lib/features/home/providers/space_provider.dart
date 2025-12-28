import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/features/home/domain/models/space.dart';
import 'package:countit/services/database_service.dart';

class SpacesNotifier extends AsyncNotifier<List<Space>> {
  @override
  Future<List<Space>> build() async {
    return await DatabaseService().getSpaces();
  }
}

final spacesProvider = AsyncNotifierProvider<SpacesNotifier, List<Space>>(() {
  return SpacesNotifier();
});
