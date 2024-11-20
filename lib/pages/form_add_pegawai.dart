import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/pegawai_controller.dart';
import 'package:test_task/controller/wilayah_controller.dart';
import 'package:test_task/model/pegawai.dart';
import 'package:test_task/model/wilayah.dart';

class EmployeeAddForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  EmployeeAddForm() {
    if (!Get.isRegistered<RegionController>()) {
      Get.put(RegionController());
    }

    final regionController = Get.find<RegionController>();
    regionController.resetSelections();
  }

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();
    final regionController = Get.find<RegionController>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 51, 102, 1.0),
        foregroundColor: Colors.white,
        title: Text(
          'Add Employee',
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Nama',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                hintText: 'Masukkan nama',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Please enter name' : null,
            ),
            SizedBox(height: 10),
            Text(
              'Jalan',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Masukkan nama jalan',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Please enter address' : null,
            ),
            SizedBox(height: 10),
            Text(
              'Provinsi',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            Obx(() => DropdownButtonFormField<Province>(
              value: regionController.selectedProvince.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                hintText: 'Pilih provinsi',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: regionController.provinces
                  .map((province) => DropdownMenuItem(
                value: province,
                child: Text(
                    province.name ?? '',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              onChanged: (province) {
                if (province != null) {
                  regionController.selectedProvince.value = province;
                  regionController.fetchRegencies(province.id!);
                  regionController.selectedRegency.value = null;
                  regionController.selectedDistrict.value = null;
                  regionController.selectedVillage.value = null;
                }
              },
              validator: (value) => value == null ? 'Please select province' : null,
            )),
            SizedBox(height: 10),
            Text(
              'Kabupaten/ Kota',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            Obx(() => DropdownButtonFormField<Regency>(
              value: regionController.selectedRegency.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                hintText: 'Pilih kota/ kabupaten',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: regionController.regencies
                  .map((regency) => DropdownMenuItem(
                value: regency,
                child: Text(
                    regency.name ?? '',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              onChanged: regionController.selectedProvince.value != null
                  ? (regency) {
                if (regency != null) {
                  regionController.selectedRegency.value = regency;
                  regionController.fetchDistricts(regency.id!);
                  regionController.selectedDistrict.value = null;
                  regionController.selectedVillage.value = null;
                }
              }
                  : null,
              validator: (value) => value == null ? 'Please select regency' : null,
            )),
            SizedBox(height: 10),
            Text(
              'Kecamatan',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            Obx(() => DropdownButtonFormField<District>(
              value: regionController.selectedDistrict.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                hintText: 'Pilih kecamatan',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: regionController.districts
                  .map((district) => DropdownMenuItem(
                value: district,
                child: Text(
                    district.name ?? '',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              onChanged: regionController.selectedRegency.value != null
                  ? (district) {
                if (district != null) {
                  regionController.selectedDistrict.value = district;
                  regionController.fetchVillages(district.id!);
                  regionController.selectedVillage.value = null;
                }
              }
                  : null,
              validator: (value) => value == null ? 'Please select district' : null,
            )),
            SizedBox(height: 10),
            Text(
              'Kelurahan',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),
            SizedBox(height: 5,),
            Obx(() => DropdownButtonFormField<Village>(
              value: regionController.selectedVillage.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                hintText: 'Pilih kelurahan',
                hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: regionController.villages
                  .map((village) => DropdownMenuItem(
                value: village,
                child: Text(
                    village.name ?? '',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              onChanged: regionController.selectedDistrict.value != null
                  ? (village) {
                if (village != null) {
                  regionController.selectedVillage.value = village;
                }
              }
                  : null,
              validator: (value) => value == null ? 'Please select village' : null,
            )),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final newEmployee = Employee(
                    nama: _nameController.text,
                    jalan: _addressController.text,
                    provinsi: regionController.selectedProvince.value,
                    kabupaten: regionController.selectedRegency.value,
                    kecamatan: regionController.selectedDistrict.value,
                    kelurahan: regionController.selectedVillage.value,
                  );

                  employeeController.createEmployee(newEmployee);
                  Get.back();
                }
              },
              child: Text(
                'Create',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromRGBO(0, 51, 102, 1.0)
              ),
            ),
          ],
        ),
      ),
    );
  }
}