import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hci_sign/pages/home.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final FocusNode _focusNode = FocusNode();

  final List<Map<String, String>> onboardingData = [
    {'number': '1', 'title': 'click', 'desc': '단 한 번의 클릭으로'},
    {'number': '2', 'title': 'person', 'desc': '당신과 상담방이 동시에 연결'},
    {'number': '3', 'title': 'sec', 'desc': '3초면 충분, 빠르고 간편하게'},
    {'number': '4', 'title': 'you', 'desc': '오직 당신을 위한 온보딩 아카이빙'},
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('환영합니다, ${user.displayName}님!')),
        );

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        // );
      }
    } catch (e) {
      print('로그인 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                _currentPage < onboardingData.length) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
                _currentPage > 0) {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length + 1,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                if (index == onboardingData.length) {
                  return _buildFinalPage();
                } else {
                  return _buildOnboardingPage(onboardingData[index]);
                }
              },
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length + 1,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, String> data) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            color: Colors.blue,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Color(0xFFF7F8FC),
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['number']!,
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title']!,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          data['desc']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFinalPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pan_tool_alt, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            '서명도 이렇게 쉬울 수 있는 Hi-Five 로 시작하는 스마트 서명 습관',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),

          // ✅ Google 로그인 버튼
          ElevatedButton.icon(
            icon: Icon(Icons.login),
            label: Text('Google로 시작하기'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 3,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: _signInWithGoogle,
          ),

          SizedBox(height: 12),

          // ✅ 홈페이지 이동 버튼
          ElevatedButton.icon(
            icon: Icon(Icons.home),
            label: Text('홈페이지로 이동'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
