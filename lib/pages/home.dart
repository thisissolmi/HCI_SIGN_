import 'package:flutter/material.dart';
import 'package:hci_sign/pages/signature.dart';
import 'package:hci_sign/pages/register.dart';
import 'dart:typed_data';
import 'package:hci_sign/pages/outbox.dart';
import 'package:hci_sign/pages/inbox.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      print("🟡 탭 전환됨: $index");
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return OutboxPage();
      case 1:
        return CustomHomePage();
      case 2:
        return InboxPage();
      default:
        return Center(child: Text('페이지 없음'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color(0xFF0D47A1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Outbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Inbox',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RegisterPage()),
          );
        },
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

class CustomHomePage extends StatefulWidget {
  const CustomHomePage({Key? key}) : super(key: key);

  @override
  State<CustomHomePage> createState() => _CustomHomePageState();
}

class _CustomHomePageState extends State<CustomHomePage> {
  Uint8List? _signatureImage;

  void _navigateToSignPage() async {
    final result = await Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(builder: (_) => SignPage()),
    );

    if (result != null) {
      setState(() {
        _signatureImage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[700],
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monday , May 19',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello, Taehee 👋',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Signature Requests Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusBox('New', '0', Colors.green),
                _statusBox('Reject', '0', Colors.red),
                _statusBox('Complete', '0', Colors.blue),
              ],
            ),
            SizedBox(height: 24),
            _sectionHeaderWithAction(context, 'My Sign', _navigateToSignPage),
            _signatureImage != null
                ? _signaturePreviewBox()
                : _dashedBox('No signature yet\nlet\'s add yours!'),
            SizedBox(height: 24),
            _sectionHeader('Recent Activity'),
            _dashedBox(
              'No activity yet\nAfter you send or receive a signature request,\nit will appear here.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBox(String label, String count, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Text(count,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 4),
            Text('case', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('Detail View >',
            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ],
    );
  }

  Widget _sectionHeaderWithAction(
      BuildContext context, String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Detail View >',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _dashedBox(String text) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.link_off, size: 40, color: Colors.grey[400]),
          SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _signaturePreviewBox() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.memory(_signatureImage!, height: 100),
    );
  }
}
