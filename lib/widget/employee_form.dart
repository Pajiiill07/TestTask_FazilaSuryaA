import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/wilayah_controller.dart';
import 'package:test_task/model/wilayah.dart';

class EmployeeForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final VoidCallback onSubmit;

  EmployeeForm({
    required this.formKey,
    required this.nameController,
    required this.addressController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final regionController = Get.find<RegionController>();

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Nama
          const Text(
              'Nama',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              hintText: 'Masukkan nama',
              filled: true,
              fillColor: Colors.grey[300],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Please enter name' : null,
          ),
          const SizedBox(height: 10),
          // Alamat
          const Text('Jalan',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: 'Masukkan nama jalan',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Please enter address' : null,
          ),
          const SizedBox(height: 10),
          // Provinsi Dropdown
          const Text(
              'Provinsi',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
        SizedBox(height: 5,),
        Obx(() {
          if (regionController.provinces.isEmpty) {
            return LinearProgressIndicator(); // Atau widget kosong
          }

          return DropdownButtonFormField<Province>(
            value: regionController.provinces.firstWhereOrNull(
                  (province) => province.id == regionController.selectedProvince.value?.id,
            ),
            items: regionController.provinces
                .map((province) => DropdownMenuItem<Province>(
              value: province,
              child: Text(
                  province.name ?? '',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 15
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
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              filled: true,
              fillColor: Colors.grey[300],
            ),
          );
        }),
          const SizedBox(height: 10),
          // Kabupaten Dropdown
          const Text(
            'Kabupaten/ Kota',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
          SizedBox(height: 5,),
          Obx(() {
            if (regionController.regencies.isEmpty &&
                regionController.selectedProvince.value != null) {
              return LinearProgressIndicator(); // Menunggu data Kabupaten
            }

            return DropdownButtonFormField<Regency>(
              value: regionController.regencies.firstWhereOrNull(
                    (regency) => regency.id == regionController.selectedRegency.value?.id,
              ),
              items: regionController.regencies
                  .map((regency) => DropdownMenuItem<Regency>(
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
              onChanged: (regency) {
                if (regency != null) {
                  regionController.selectedRegency.value = regency;
                  regionController.fetchDistricts(regency.id!); // Memanggil fetch untuk Kecamatan
                  regionController.selectedDistrict.value = null;
                  regionController.selectedVillage.value = null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Pilih kabupaten/kota',
              ),
              validator: (value) => value == null ? 'Pilih kabupaten/kota' : null,
            );
          }),
          const SizedBox(height: 10),
          // Kecamatan Dropdown
          const Text(
            'Kecamatan',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
          SizedBox(height: 5,),
          Obx(() {
            if (regionController.districts.isEmpty &&
                regionController.selectedRegency.value != null) {
              return LinearProgressIndicator(); // Menunggu data Kecamatan
            }

            return DropdownButtonFormField<District>(
              value: regionController.districts.firstWhereOrNull(
                    (district) => district.id == regionController.selectedDistrict.value?.id,
              ),
              items: regionController.districts
                  .map((district) => DropdownMenuItem<District>(
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
              onChanged: (district) {
                if (district != null) {
                  regionController.selectedDistrict.value = district;
                  regionController.fetchVillages(district.id!); // Memanggil fetch untuk Kelurahan
                  regionController.selectedVillage.value = null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Pilih kecamatan',
              ),
              validator: (value) => value == null ? 'Pilih kecamatan' : null,
            );
          }),
          const SizedBox(height: 10),
          // Kelurahan Dropdown
          const Text(
            'Kelurahan',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
          SizedBox(height: 5,),
          Obx(() {
            if (regionController.villages.isEmpty &&
                regionController.selectedDistrict.value != null) {
              return LinearProgressIndicator(); // Menunggu data Kelurahan
            }

            return DropdownButtonFormField<Village>(
              value: regionController.villages.firstWhereOrNull(
                    (village) => village.id == regionController.selectedVillage.value?.id,
              ),
              items: regionController.villages
                  .map((village) => DropdownMenuItem<Village>(
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
              onChanged: (village) {
                if (village != null) {
                  regionController.selectedVillage.value = village;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Pilih kelurahan',
              ),
              validator: (value) => value == null ? 'Pilih kelurahan' : null,
            );
          }),
          // Tambahkan dropdown untuk kabupaten, kecamatan, kelurahan sesuai pola
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 51, 102, 1.0),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
