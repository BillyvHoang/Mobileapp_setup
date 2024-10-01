import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp_setup/features/auth/presentation/page/login_page.dart';
import 'package:mobileapp_setup/service/firebase_service.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeApp();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     home: LoginPage(),
    );
  }
}


