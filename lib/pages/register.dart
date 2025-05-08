import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isFileUploaded = false; // 파일이 업로드 되었는지 여부
  String _fileName = ""; // 파일 이름

  // 파일 선택 버튼을 눌렀을 때 파일이 업로드된 상태로 변경
  void _uploadFile() {
    setState(() {
      _isFileUploaded = true;
      _fileName = "8W TA Weekly Report.pdf"; // 예시 파일 이름
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Section
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

            // File Upload Section
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

            // File List Section (if file is uploaded)
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

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300], // backgroundColor로 설정
                    foregroundColor: Colors.black, // foregroundColor로 설정
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
