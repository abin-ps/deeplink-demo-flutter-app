import 'package:deeplink_demo_app/screens/demo_screen.dart';
import 'package:deeplink_demo_app/screens/products_screen.dart';
import 'package:go_router/go_router.dart';

import 'screens/product_details_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DemoScreen(),
      routes: [
        GoRoute(
          path: 'products/:itemId',
          builder: (context, state) => ProductDetailsScreen(id: state.pathParameters['itemId']!),
        )
      ],
    )
  ],
);
