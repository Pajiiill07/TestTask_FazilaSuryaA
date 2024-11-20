import 'package:flutter/material.dart';
import 'package:test_task/controller/pegawai_controller.dart';
import 'package:test_task/controller/wilayah_controller.dart';
import 'package:test_task/pages/list_pegawai.dart';
import 'package:get/get.dart';
import 'package:test_task/service/api_service.dart';

void main() {
  Get.put(ApiService());
  Get.put(EmployeeController());
  Get.put(RegionController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 51, 102, 1.0)),
        useMaterial3: true,
      ),
      home: EmployeeListView(),
    );
  }
}