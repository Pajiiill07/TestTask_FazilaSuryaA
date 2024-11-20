// lib/services/api_service.dart
import 'package:get/get.dart';
import 'package:test_task/model/pegawai.dart';
import 'package:test_task/model/wilayah.dart';

class ApiService extends GetConnect {
  static const String employeeBaseUrl = 'https://61601920faa03600179fb8d2.mockapi.io/pegawai';
  static const String regionBaseUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api';

  // Employee API calls
  Future<List<Employee>> getEmployees() async {
    final response = await get(employeeBaseUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return (response.body as List)
        .map((item) => Employee.fromJson(item))
        .toList();
  }

  Future<Response> createEmployee(Employee employee) async {
    return await post(employeeBaseUrl, employee.toJson());
  }

  Future<Response> updateEmployee(String id, Employee employee) async {
    return await put('$employeeBaseUrl/$id', employee.toJson());
  }

  Future<Response> deleteEmployee(String id) async {
    return await delete('$employeeBaseUrl/$id');
  }

  // Region API calls
  Future<List<Province>> getProvinces() async {
    final response = await get('$regionBaseUrl/provinces.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return (response.body as List)
        .map((item) => Province.fromJson(item))
        .toList();
  }

  Future<List<Regency>> getRegencies(String provinceId) async {
    final response = await get('$regionBaseUrl/regencies/$provinceId.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return (response.body as List)
        .map((item) => Regency.fromJson(item))
        .toList();
  }

  Future<List<District>> getDistricts(String regencyId) async {
    final response = await get('$regionBaseUrl/districts/$regencyId.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return (response.body as List)
        .map((item) => District.fromJson(item))
        .toList();
  }

  Future<List<Village>> getVillages(String districtId) async {
    final response = await get('$regionBaseUrl/villages/$districtId.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return (response.body as List)
        .map((item) => Village.fromJson(item))
        .toList();
  }
}