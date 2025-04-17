import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 작업 페이지'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // 오른쪽 햄버거 메뉴 기능
            },
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '오늘의 작업 페이지',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: '작업',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit, color: Colors.black),
        backgroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(color: Colors.black, width: 1.5),
        ),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
