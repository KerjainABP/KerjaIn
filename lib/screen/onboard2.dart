import 'package:flutter/material.dart';
import 'package:kerjain/screen/daftarPerusahaan.dart';
import 'package:kerjain/screen/loginPerusahaan.dart';
import 'package:kerjain/screen/onboard.dart';
import 'package:kerjain/screen/splash.dart';

class Onboard2 extends StatefulWidget {
  const Onboard2({super.key});

  @override
  _KerjaOnboard2 createState() => _KerjaOnboard2();
}

class _KerjaOnboard2 extends State<Onboard2> {
  // Login logic and form fields here

  void navigateToHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const kerjaSplash()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Center horizontally
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    child: SizedBox(
                      width: 160,
                      child: ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),

                                  ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Onboard()),
                            );
                          },
                          child: const Text(
                            "Pekerja",
                            style: TextStyle(color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                  SizedBox(width: 40,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Color.fromRGBO(5, 26, 73, 1), width: 2),
                              ))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Onboard2()),
                        );
                      },
                      child: const Text(

                        "Perusahaan",
                        style: TextStyle(color: Colors.black,

                            fontFamily: 'Poppins',
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )),
                ],

              ),
              SizedBox(height: 40,),
              Image.asset(
                'assets/kerjain.png', // Replace with your image path
                height: 200.0, // Adjust image height as needed
                width: double.infinity, // Set width to full screen
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Align( // Center the text horizontally within the padding
                  alignment: Alignment.center,
                  child: Text(
                    'Temukan Bakat yang cocok dengan perusahaan Anda!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
                children: [
                  Container(
                    child: SizedBox(
                      width: 280,
                      height: 52,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(5, 26, 73, 1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreenPerusahaan()),
                            );
                          },
                          child: const Text(
                            "Masuk",
                            style: TextStyle(color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  const SizedBox(width: 20.0,height: 20,), // Add spacing between buttons
                  Container(
                    child: SizedBox(
                      width: 280,
                      height: 52,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: Color.fromRGBO(5, 26, 73, 1), width: 2),
                                  ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DaftarPerusahaan()),
                            );
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
