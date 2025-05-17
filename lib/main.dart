import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // 꼭 import!
import 'package:hci_sign/screens/onboarding_screen.dart'; // 조이의 온보딩 파일
// import 'package:hci_sign/pages/home.dart'; // 이제 직접 호출은 안 해도 됨

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
      debugShowCheckedModeBanner: false,
      title: 'Hi-Five',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(), // 온보딩 화면에서 시작
    );
  }
}
