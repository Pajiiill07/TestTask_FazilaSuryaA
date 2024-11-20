import 'package:get/get.dart';
import 'package:test_task/model/pegawai.dart';
import 'package:test_task/service/api_service.dart';

class EmployeeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final employees = <Employee>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading(true);
      final result = await _apiService.getEmployees();
      employees.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createEmployee(Employee employee) async {
    try {
      isLoading(true);
      await _apiService.createEmployee(employee);
      await fetchEmployees();
      Get.back();
      Get.snackbar('Success', 'Employee created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateEmployee(String id, Employee employee) async {
    try {
      isLoading(true);
      await _apiService.updateEmployee(id, employee);
      await fetchEmployees();
      Get.back();
      Get.snackbar('Success', 'Employee updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      isLoading(true);
      await _apiService.deleteEmployee(id);
      await fetchEmployees();
      Get.snackbar('Success', 'Employee deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}