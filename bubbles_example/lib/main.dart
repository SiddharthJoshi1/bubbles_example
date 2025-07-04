import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'presentation/main_delivery_journey/delivery_journey_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async operations before runApp
  di.init(); // Initialize dependency injection
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Delivery Bubbles Demo',
      home: Scaffold(body: DeliveryJourneyPage()),
    );
  }
}
