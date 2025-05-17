import 'package:flutter/material.dart';

class OutboxPage extends StatefulWidget {
  @override
  _OutboxPageState createState() => _OutboxPageState();
}

class _OutboxPageState extends State<OutboxPage> {
  bool isInProgress = true;

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
                    Text('Outbox 📤',
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "You can search your documents",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Opacity(
                    opacity: 0.3,
                    child: Icon(Icons.link_off, size: 60),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "No sign requests yet.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Documents will appear here once you receive a request.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
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
        width: 100,
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
}
