import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/verification_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _obscureText =
      true; // Ini mengontrol apakah password terlihat atau tidak
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Text(
                  'Daftar Akun',
                  style: TextStyle(
                      fontSize: 24),
                ),
                Text(
                  'Lengkapi informasi dibawah ini',
                  style: TextStyle(color: Color.fromRGBO(177, 177, 177, 1), fontSize: 14),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        244, 244, 244, 1), // Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/profile.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'Nama depan', // Hint text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 244, 244, 1),

                    /// Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/profile.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'Nama belakang', // Hint text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        244, 244, 244, 1), // Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/sms.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'Masukan email', // Hint text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        244, 244, 244, 1), // Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/lock.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'Setting password', // Hint text
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            _togglePasswordVisibility, // Panggil fungsi saat ikon mata diklik
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            _obscureText
                                ? 'assets/icon/eye.png' // Gambar mata biasa
                                : 'assets/icon/eye-slash.png', // Gambar mata slash
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        244, 244, 244, 1), // Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/location.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'Alamat', // Hint text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        244, 244, 244, 1), // Warna latar belakang abu-abu
                    borderRadius:
                        BorderRadius.circular(30), // Border radius rounded
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12), // Padding horizontal
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 30,
                            left: MediaQuery.of(context).size.width /
                                30), // Padding kanan
                        child: Image.asset(
                          'assets/icon/mobile.png', // Path ke gambar Anda
                          width: 20, // Lebar gambar
                          height: 20, // Tinggi gambar
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hilangkan garis bawah
                            hintText: 'No Handphone', // Hint text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 60,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Saya setuju dengan ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(60, 60, 60, 1))
                      ),
                      TextSpan(
                        text: 'Ketentuan layanan',
                        style: TextStyle(color: Color.fromRGBO(54, 159, 255, 1), fontSize: 12),
                        // Tambahkan aksi ketika ditekan 54, 159, 255
                      ),
                      TextSpan(
                        text: '\n dan ', style: TextStyle(fontSize: 12, color: Color.fromRGBO(60, 60, 60, 1))
                      ),
                      TextSpan(
                        text: 'Kebijakan privasi',
                        style: TextStyle(color: Color.fromRGBO(54, 159, 255, 1), fontSize: 12),
                        // Tambahkan aksi ketika ditekan
                      ),
                      TextSpan(
                        text: ' aplikasi Vokta', style: TextStyle(fontSize: 12, color: Color.fromRGBO(60, 60, 60, 1)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => VerificationPage());
                      // Aksi yang ingin dilakukan saat tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30), // Atur radius sesuai keinginan
                      ),
                      backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 13), // Warna latar belakang tombol
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        'Daftar',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
