import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isFileUploaded = false;
  String _fileName = "";

  void _uploadFile() {
    setState(() {
      _isFileUploaded = true;
      _fileName = "8W TA Weekly Report.pdf";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[700],
          elevation: 0,
          automaticallyImplyLeading: true, // 뒤로가기 버튼 표시
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
                    Text('Register Page',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Receiver Assign the Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter email address',
              ),
            ),
            SizedBox(height: 16),
            Text("Task Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
            SizedBox(height: 16),
            Text("Task Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter task description',
              ),
            ),
            SizedBox(height: 16),
            Text("Expiration Date & Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Select Time',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Select Document",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text("Add your documents here, and you can upload up to 1 file"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
            SizedBox(height: 16),
            if (_isFileUploaded) ...[
              Text("File List:"),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(_fileName),
                  SizedBox(width: 8),
                  Text("(5.3MB)", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Next 동작 처리
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
