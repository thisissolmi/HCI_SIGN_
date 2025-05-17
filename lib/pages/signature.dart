import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:signature/signature.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  Uint8List? _signatureImage;

  void _openSignaturePopup() async {
    final result = await showDialog<Uint8List>(
      context: context,
      builder: (context) => SignaturePopup(),
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
      appBar: AppBar(
        title: Text('My Sign'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _signatureImage); // ✅ 싸인 이미지 전달!
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Draw your digital Signature',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Use your finger to draw your signature below.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 30),

            /// ? 점선 박스 + 미리보기 or Click Here
            GestureDetector(
              onTap: _openSignaturePopup,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                color: Colors.grey,
                dashPattern: [6, 4],
                strokeWidth: 2,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Center(
                    child: _signatureImage != null
                        ? Image.memory(_signatureImage!)
                        : Text('Click Here'),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'This signature will be used when\nyou sign future documents.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _openSignaturePopup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text('Edit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignaturePopup extends StatefulWidget {
  @override
  _SignaturePopupState createState() => _SignaturePopupState();
}

class _SignaturePopupState extends State<SignaturePopup> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ? 상단 영역: 설명 + 배경
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF0D47A1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Draw your digital Signature',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  'Use your finger to draw your signature below.',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),

          // ? 캔버스: 점선 테두리 안에 Signature 위젯
          Padding(
            padding: const EdgeInsets.all(20),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              dashPattern: [6, 4],
              color: Colors.grey,
              strokeWidth: 2,
              child: Container(
                height: 200,
                width: double.infinity,
                child: Signature(
                  controller: _controller,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),

          // 하단 버튼 영역
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back 버튼
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Back'),
                ),

                // Clear 버튼
                OutlinedButton(
                  onPressed: _controller.clear,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Clear'),
                ),

                // Register 버튼
                ElevatedButton(
                  onPressed: () async {
                    final image = await _controller.toPngBytes();
                    if (image != null) {
                      Navigator.pop(context, image);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D47A1), // 진파랑
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}