import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerjain/screen/DetailJob/DetailJobUser.dart';
import 'package:kerjain/screen/KelolaIklan.dart';
import 'package:kerjain/screen/Perusahaan/BerhentiPekerja.dart';
import 'package:kerjain/screen/Perusahaan/LihatPekerja.dart';

import 'package:kerjain/screen/splash.dart';
import 'package:get/get.dart';

void main() {
  runApp(const KerjaIn());
}

class KerjaIn extends StatelessWidget {
  const KerjaIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KerjaIn',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const kerjaSplash(),
      getPages: [
        GetPage(name: "/detailPage/:id", page: () => JobDetailScreen()),
        GetPage(name: "/kelolaIklan/:id", page: () => KelolaIklanPage()),
        GetPage(name: "/lihatPekerja/:id", page: () => Lihatpekerja()),
        GetPage(name: "/kelolaPegawai/:id", page: () => Berhentipekerja()),
      ],
    );
  }
}
