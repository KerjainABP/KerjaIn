import 'package:flutter/material.dart';
import 'package:kerjain/screen/home.dart';

class LoginPerusahaan extends StatelessWidget {
  const LoginPerusahaan({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset('assets/kerjain.png'),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      child: const Text(
                        "Halo, Selamat Datang",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: Text(
                        'Beragam pekerja dari berbagai bidang menanti Perusahaan Anda. ',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(5, 26, 73, 1),
                    borderRadius: BorderRadius.circular(10.0), // Set the border radius
                  ),
                  padding: const EdgeInsets.only(left: 25,right: 25,top: 44),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.white),
                                  ),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18, fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Create account action
                              },
                              child: Center(
                                child: Text(
                                  "Tidak punya akun?",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(125, 135, 151, 1),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
