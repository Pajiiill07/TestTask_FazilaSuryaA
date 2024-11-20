import 'package:get/get.dart';
import 'package:test_task/model/wilayah.dart';
import 'package:test_task/service/api_service.dart';

class RegionController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final provinces = <Province>[].obs;
  final regencies = <Regency>[].obs;
  final districts = <District>[].obs;
  final villages = <Village>[].obs;

  final selectedProvince = Rxn<Province>();
  final selectedRegency = Rxn<Regency>();
  final selectedDistrict = Rxn<District>();
  final selectedVillage = Rxn<Village>();

  var isLoadingProvinces = false.obs;
  var isLoadingRegencies = false.obs;
  var isLoadingDistricts = false.obs;
  var isLoadingVillages = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    try {
      isLoadingProvinces.value = true;
      // Fetch provinces from your API
      provinces.value = await _apiService.getProvinces();
    } catch (e) {
      print('Error fetching provinces: $e');
    } finally {
      isLoadingProvinces.value = false;
    }
  }

  Future<void> fetchRegencies(String provinceId) async {
    try {
      isLoadingRegencies.value = true;
      regencies.clear();
      // Clear subsequent selections
      selectedRegency.value = null;
      selectedDistrict.value = null;
      selectedVillage.value = null;
      districts.clear();
      villages.clear();

      regencies.value = await _apiService.getRegencies(provinceId);
    } catch (e) {
      print('Error fetching regencies: $e');
    } finally {
      isLoadingRegencies.value = false;
    }
  }

  Future<void> fetchDistricts(String regencyId) async {
    try {
      isLoadingDistricts.value = true;
      districts.clear();
      // Clear subsequent selections
      selectedDistrict.value = null;
      selectedVillage.value = null;
      villages.clear();

      districts.value = await _apiService.getDistricts(regencyId);
    } catch (e) {
      print('Error fetching districts: $e');
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  Future<void> fetchVillages(String districtId) async {
    try {
      isLoadingVillages.value = true;
      villages.clear();
      selectedVillage.value = null;

      villages.value = await _apiService.getVillages(districtId);
    } catch (e) {
      print('Error fetching villages: $e');
    } finally {
      isLoadingVillages.value = false;
    }
  }

  void resetSelections() {
    selectedProvince.value = null;
    selectedRegency.value = null;
    selectedDistrict.value = null;
    selectedVillage.value = null;
    regencies.clear();
    districts.clear();
    villages.clear();
  }
}