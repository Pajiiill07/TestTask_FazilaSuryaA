import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/pegawai_controller.dart';
import 'package:test_task/controller/wilayah_controller.dart';
import 'package:test_task/model/pegawai.dart';
import 'package:test_task/widget/employee_form.dart';

class EmployeeEditForm extends StatelessWidget {
  final Employee employee;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  EmployeeEditForm({required this.employee}) {
    if (!Get.isRegistered<RegionController>()) {
      Get.put(RegionController());
    }

    _nameController.text = employee.nama ?? '';
    _addressController.text = employee.jalan ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final regionController = Get.find<RegionController>();

      // Reset selections
      regionController.selectedProvince.value = null;
      regionController.selectedRegency.value = null;
      regionController.selectedDistrict.value = null;
      regionController.selectedVillage.value = null;

      // Load provinces first
      await regionController.fetchProvinces();

      if (employee.provinsi?.id != null) {
        // Set province and fetch regencies
        regionController.selectedProvince.value = employee.provinsi;
        await regionController.fetchRegencies(employee.provinsi!.id!);

        if (employee.kabupaten?.id != null) {
          // Set regency and fetch districts
          regionController.selectedRegency.value = employee.kabupaten;
          await regionController.fetchDistricts(employee.kabupaten!.id!);

          if (employee.kecamatan?.id != null) {
            // Set district and fetch villages
            regionController.selectedDistrict.value = employee.kecamatan;
            await regionController.fetchVillages(employee.kecamatan!.id!);

            if (employee.kelurahan?.id != null) {
              // Set village
              regionController.selectedVillage.value = employee.kelurahan;
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();
    final regionController = Get.find<RegionController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1.0),
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Employee',
          style: TextStyle(
              fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: EmployeeForm(
        formKey: _formKey,
        nameController: _nameController,
        addressController: _addressController,
        onSubmit: () {
          if (_formKey.currentState?.validate() ?? false) {
            final updatedEmployee = Employee(
              id: employee.id,
              nama: _nameController.text,
              jalan: _addressController.text,
              provinsi: regionController.selectedProvince.value,
              kabupaten: regionController.selectedRegency.value,
              kecamatan: regionController.selectedDistrict.value,
              kelurahan: regionController.selectedVillage.value,
            );

            employeeController.updateEmployee(employee.id!, updatedEmployee);
          }
        },
      ),
    );
  }
}
