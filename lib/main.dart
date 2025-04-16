import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // 꼭 import!
import 'package:hci_sign/screens/onboarding_screen.dart'; // 조이의 온보딩 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 초기화 준비
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hi-Five',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(),
    );
  }
}
