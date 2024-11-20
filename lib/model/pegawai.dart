import 'package:test_task/model/wilayah.dart';

class Employee {
  String? id;
  String? nama;
  String? jalan;
  Province? provinsi;
  Regency? kabupaten;
  District? kecamatan;
  Village? kelurahan;

  Employee({
    this.id,
    this.nama,
    this.jalan,
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.kelurahan,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    jalan = json['jalan'];
    provinsi = json['provinsi'] != null ? Province.fromJson(json['provinsi']) : null;
    kabupaten = json['kabupaten'] != null ? Regency.fromJson(json['kabupaten']) : null;
    kecamatan = json['kecamatan'] != null ? District.fromJson(json['kecamatan']) : null;
    kelurahan = json['kelurahan'] != null ? Village.fromJson(json['kelurahan']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'jalan': jalan,
      'provinsi': provinsi?.toJson(),
      'kabupaten': kabupaten?.toJson(),
      'kecamatan': kecamatan?.toJson(),
      'kelurahan': kelurahan?.toJson(),
    };
  }
}