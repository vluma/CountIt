import 'package:go_router/go_router.dart';
import 'package:countit/features/home/presentation/pages/home_page.dart';
import 'package:countit/features/item_detail/presentation/pages/item_detail_page.dart';
import 'package:countit/features/inventory/presentation/pages/add_item_page.dart';
import 'package:countit/features/inventory/presentation/pages/inventory_page.dart';
import 'package:countit/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  GoRouter get router {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/item/:id',
          name: 'itemDetail',
          builder: (context, state) => ItemDetailPage(id: state.pathParameters['id']!),
        ),
        GoRoute(
          path: '/add-item',
          name: 'addItem',
          builder: (context, state) => const AddItemPage(),
        ),
        GoRoute(
          path: '/inventory',
          name: 'inventory',
          builder: (context, state) => const InventoryPage(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    );
  }
}
