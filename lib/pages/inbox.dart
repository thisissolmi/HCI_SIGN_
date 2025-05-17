import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  bool isInProgress = true;

  // 목업 데이터
  final List<Map<String, String>> inProgressItems = [
    {
      'title': '개별연구 신청하기',
      'to': '양사오펑 교수님',
      'date': '2025 / 02 / 06',
    },
    {
      'title': '캡스톤 서명 요청',
      'to': '김철수 교수님',
      'date': '2025 / 03 / 01',
    },
  ];

  final List<Map<String, String>> doneItems = [
    {
      'title': '프로젝트 보고서 확인',
      'to': '이은영 교수님',
      'date': '2025 / 01 / 15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = isInProgress ? inProgressItems : doneItems;

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
      body: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tabButton("Inprogress", true),
              _tabButton("Done", false),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) => _inboxCard(
                title: items[index]['title']!,
                to: items[index]['to']!,
                date: items[index]['date']!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, bool isLeft) {
    final selected = (isLeft && isInProgress) || (!isLeft && !isInProgress);
    return GestureDetector(
      onTap: () {
        setState(() {
          isInProgress = isLeft;
        });
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.blue[700] : Colors.blue[200],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _inboxCard({required String title, required String to, required String date}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue, // ✅ 아이콘 컬러 통일
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.mail_outline, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("To. $to",
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
                SizedBox(height: 4),
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Expired Date : $date",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.chevron_right, color: Colors.grey[400]),
              Text("View Detail",
                  style: TextStyle(fontSize: 10, color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}

