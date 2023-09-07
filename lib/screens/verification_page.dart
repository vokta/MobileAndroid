import 'package:flutter/material.dart';
import 'package:vokta_app/screens/success_verification.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(5, (index) => FocusNode());
    _controllers = List.generate(5, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              'Kode Verifikasi',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.height / 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text('Kami mengirim 5 digit angka\nke email kamu',
                style: TextStyle(color: Colors.grey[500]),
                textAlign: TextAlign.center),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: SizedBox(
                    width: 60,
                    height: 100, // Set tinggi TextField
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(fontSize: 24), // Ukuran teks
                      textAlign: TextAlign.center, // Teks tengah
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Colors.grey[300], // Warna latar belakang abu-abu
                        counterText: '',
                        hintText: '-',
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 4) {
                            _focusNodes[index + 1].requestFocus();
                          } else {
                            _focusNodes[index].unfocus();
                          }
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
            Text('Tidak menerima kode?'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            GestureDetector(
              onTap: () {
                // Logika untuk mengirim kode lagi
              },
              child: Text(
                'Kirim kode lagi',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SuccessVerification();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Atur radius sesuai keinginan
                  ),
                  backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13), // Warna latar belakang tombol
                ),
                child: Container(
                  width: screenWidth * 0.4,
                  child: Text(
                    'Verifikasi',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
